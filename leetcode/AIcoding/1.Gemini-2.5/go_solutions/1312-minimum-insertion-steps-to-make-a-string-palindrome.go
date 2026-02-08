func minInsertions(s string) int {
    n := len(s)
    if n <= 1 {
        return 0
    }

    sRev := make([]byte, n)
    for i := 0; i < n; i++ {
        sRev[i] = s[n-1-i]
    }

    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for i := 1; i <= n; i++ {
        for j := 1; j <= n; j++ {
            if s[i-1] == sRev[j-1] {
                dp[i][j] = 1 + dp[i-1][j-1]
            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            }
        }
    }

    return n - dp[n][n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}