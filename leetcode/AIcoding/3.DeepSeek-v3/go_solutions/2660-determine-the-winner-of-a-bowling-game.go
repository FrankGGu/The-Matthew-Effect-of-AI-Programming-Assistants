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

func calculateScore(rolls []int) int {
    score := 0
    for i := 0; i < len(rolls); i++ {
        if (i >= 1 && rolls[i-1] == 10) || (i >= 2 && rolls[i-2] == 10) {
            score += 2 * rolls[i]
        } else {
            score += rolls[i]
        }
    }
    return score
}