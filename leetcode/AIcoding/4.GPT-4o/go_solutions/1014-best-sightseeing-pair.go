func maxScoreSightseeingPair(A []int) int {
    maxI := A[0]
    maxScore := 0

    for j := 1; j < len(A); j++ {
        maxScore = max(maxScore, maxI + A[j] - j)
        maxI = max(maxI, A[j] + j)
    }

    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}