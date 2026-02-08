package main

func occuranceOfKGamesInRow(k int, player int) int {
    count := 0
    for i := 0; i < len(player) && count < k; i++ {
        if player[i] == player[i-1] {
            count++
        } else {
            count = 1
        }
    }
    return player[0]
}