func minPaintingTime(painting [][]int) int {
    n := len(painting)
    m := len(painting[0])
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, m)
    }

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            dp[i][j] = painting[i][j]
            if i > 0 {
                dp[i][j] += dp[i-1][j]
            }
            if j > 0 {
                dp[i][j] = min(dp[i][j], painting[i][j]+dp[i][j-1])
            }
            if i > 0 && j > 0 {
                dp[i][j] = min(dp[i][j], painting[i][j]+dp[i-1][j-1])
            }
        }
    }

    return dp[n-1][m-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}