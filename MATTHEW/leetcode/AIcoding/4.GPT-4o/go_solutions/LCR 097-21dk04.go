func numDistinct(s string, t string) int {
    m, n := len(s), len(t)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }
    for j := 0; j <= m; j++ {
        dp[0][j] = 1
    }
    for i := 1; i <= n; i++ {
        for j := 1; j <= m; j++ {
            if t[i-1] == s[j-1] {
                dp[i][j] = dp[i-1][j-1] + dp[i][j-1]
            } else {
                dp[i][j] = dp[i][j-1]
            }
        }
    }
    return dp[n][m]
}