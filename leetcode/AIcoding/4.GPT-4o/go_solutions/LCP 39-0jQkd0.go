func numOfPaths(n int) int {
    const mod = 1e9 + 7
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[0][0] = 1

    for i := 0; i <= n; i++ {
        for j := 0; j <= n; j++ {
            if i > 0 {
                dp[i][j] = (dp[i][j] + dp[i-1][j]) % mod
            }
            if j > 0 {
                dp[i][j] = (dp[i][j] + dp[i][j-1]) % mod
            }
        }
    }
    return dp[n][n]
}