func numberOfWinners(players []int) int {
    maxScore := 0
    scoreCount := make(map[int]int)

    for _, score := range players {
        scoreCount[score]++
        if score > maxScore {
            maxScore = score
        }
    }

    winningCount := scoreCount[maxScore]

    for score := range scoreCount {
        if score + 1 == maxScore {
            winningCount += scoreCount[score]
        }
    }

    return winningCount
}