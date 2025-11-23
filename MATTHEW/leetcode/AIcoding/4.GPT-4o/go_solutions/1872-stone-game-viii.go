func stoneGameVIII(stones []int) int {
    n := len(stones)
    for i := 1; i < n; i++ {
        stones[i] += stones[i-1]
    }
    maxScore := stones[n-1]
    result := maxScore
    for i := n - 2; i > 0; i-- {
        maxScore = max(maxScore, stones[i])
        result = max(result, maxScore - stones[i])
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}