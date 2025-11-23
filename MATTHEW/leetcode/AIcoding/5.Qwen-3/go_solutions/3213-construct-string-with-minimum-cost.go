package main

func minCostPath(s string) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + 10
        if i >= 2 && s[i-2] == s[i-1] {
            dp[i] = min(dp[i], dp[i-2]+10)
        }
        if i >= 3 && s[i-3] == s[i-2] && s[i-2] == s[i-1] {
            dp[i] = min(dp[i], dp[i-3]+10)
        }
    }
    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}