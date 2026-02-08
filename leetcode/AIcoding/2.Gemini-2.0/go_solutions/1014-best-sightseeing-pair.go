func maxScoreSightseeingPair(values []int) int {
    maxScore := 0
    maxSoFar := values[0] + 0
    for j := 1; j < len(values); j++ {
        score := maxSoFar + values[j] - j
        if score > maxScore {
            maxScore = score
        }
        if values[j] + j > maxSoFar {
            maxSoFar = values[j] + j
        }
    }
    return maxScore
}