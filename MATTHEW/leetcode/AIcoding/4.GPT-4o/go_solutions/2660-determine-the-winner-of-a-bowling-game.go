func isWinner(players []int) int {
    player1Score, player2Score := 0, 0
    for i, score := range players {
        if i == 0 {
            player1Score += score
            if len(players) > 1 {
                player2Score += players[1]
            }
        } else {
            player2Score += score
            if len(players) > 0 {
                player1Score += players[0]
            }
        }
    }

    if player1Score > player2Score {
        return 1
    } else if player2Score > player1Score {
        return 2
    } else {
        return 0
    }
}