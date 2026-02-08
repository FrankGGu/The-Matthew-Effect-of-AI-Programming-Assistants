package main

func maxLengthDifferentSubsequence(s string, k int) int {
    n := len(s)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    for i := 1; i <= n; i++ {
        for j := 0; j <= k; j++ {
            dp[i][j] = dp[i-1][j]
            if j > 0 && s[i-1] != s[i-2] {
                dp[i][j] = max(dp[i][j], dp[i-1][j-1]+1)
            }
        }
    }
    return dp[n][k]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}