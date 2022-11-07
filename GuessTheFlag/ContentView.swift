//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Stefano Dongowski on 11/6/22.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreTitle = "Game over!"
    @State private var score = 0
    @State private var attempts = 0
    @State private var showFinalScore = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700
                
            )
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                
                ForEach(0..<3) {number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                    }
                    .shadow(radius: 5)
                }
                Text("Score: \(score)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
            }
            
        }
        .alert(scoreTitle, isPresented: $showFinalScore) {
            Button("New game", action: newGame)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    func flagTapped(_ num: Int) {
        if num == correctAnswer {
            score += 1
        }
        attempts += 1
        if attempts <= 20 {
            askQuestion()
        } else {
            showFinalScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = score
    }
    
    func newGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
