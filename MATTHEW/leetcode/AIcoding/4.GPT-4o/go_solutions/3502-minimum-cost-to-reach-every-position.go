func minCost(startPos int, endPos int, k int, costs []int) int64 {
    n := len(costs)
    dp := make([][]int64, k+1)
    for i := range dp {
        dp[i] = make([]int64)(endPos-startPos+2)
        for j := range dp[i] {
            dp[i][j] = math.MaxInt64
        }
    }
    dp[0][startPos] = 0

    for i := 1; i <= k; i++ {
        for j := 0; j <= endPos; j++ {
            if j > 0 {
                dp[i][j] = min(dp[i][j], dp[i][j-1])
            }
            if j < endPos {
                dp[i][j] = min(dp[i][j], dp[i][j+1])
            }
            if j+i <= endPos {
                dp[i][j+i] = min(dp[i][j+i], dp[i-1][j]+costs[j])
            }
            if j-i >= 0 {
                dp[i][j-i] = min(dp[i][j-i], dp[i-1][j]+costs[j])
            }
        }
    }

    result := math.MaxInt64
    for i := 0; i <= k; i++ {
        result = min(result, dp[i][endPos])
    }
    return result
}

func min(a, b int64) int64 {
    if a < b {
        return a
    }
    return b
}