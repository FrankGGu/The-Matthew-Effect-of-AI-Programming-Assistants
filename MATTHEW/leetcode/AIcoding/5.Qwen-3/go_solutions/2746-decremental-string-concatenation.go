package main

func minimizeConcatenation(s string, t string) int {
    n := len(s)
    m := len(t)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }
    for i := 0; i <= n; i++ {
        for j := 0; j <= m; j++ {
            if i == 0 && j == 0 {
                dp[i][j] = 0
            } else if i == 0 {
                dp[i][j] = dp[i][j-1] + 1
            } else if j == 0 {
                dp[i][j] = dp[i-1][j] + 1
            } else {
                if s[i-1] == t[j-1] {
                    dp[i][j] = dp[i-1][j-1]
                } else {
                    dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + 1
                }
            }
        }
    }
    return dp[n][m]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}