func maxScoreSightseeingPair(values []int) int {
    maxScore := 0
    maxI := values[0] + 0

    for j := 1; j < len(values); j++ {
        currentScore := maxI + values[j] - j
        if currentScore > maxScore {
            maxScore = currentScore
        }
        if values[j] + j > maxI {
            maxI = values[j] + j
        }
    }

    return maxScore
}