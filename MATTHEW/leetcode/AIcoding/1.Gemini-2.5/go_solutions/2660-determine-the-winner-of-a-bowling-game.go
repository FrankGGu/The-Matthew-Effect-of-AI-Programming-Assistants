func isWinner(player1 []int, player2 []int) int {
    score1 := calculateScore(player1)
    score2 := calculateScore(player2)

    if score1 > score2 {
        return 1
    } else if score2 > score1 {
        return 2
    } else {
        return 0
    }
}

func calculateScore(player []int) int {
    totalScore := 0
    n := len(player)
    for i := 0; i < n; i++ {
        currentTurnScore := player[i]

        shouldDouble := false
        if i >= 1 && player[i-1] == 10 {
            shouldDouble = true
        } else if i >= 2 && player[i-2] == 10 {
            shouldDouble = true
        }

        if shouldDouble {
            totalScore += 2 * currentTurnScore
        } else {
            totalScore += currentTurnScore
        }
    }
    return totalScore
}