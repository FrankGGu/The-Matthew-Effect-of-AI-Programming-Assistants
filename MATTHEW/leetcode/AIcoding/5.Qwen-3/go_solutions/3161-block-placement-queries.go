package main

func numberOfWays(s string, k int) int {
    n := len(s)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    for i := 0; i < n; i++ {
        if s[i] == '0' {
            dp[i][0] = 1
        }
    }
    for i := 1; i < n; i++ {
        for j := 1; j <= k; j++ {
            dp[i][j] = dp[i-1][j]
            if s[i] == '0' {
                dp[i][j] += dp[i-1][j-1]
            }
        }
    }
    return dp[n-1][k]
}