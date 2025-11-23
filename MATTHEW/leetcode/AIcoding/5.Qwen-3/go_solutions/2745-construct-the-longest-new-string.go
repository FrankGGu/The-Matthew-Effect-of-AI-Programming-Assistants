package main

func longestString(n int) int {
    dp := make([]int, n+1)
    for i := 2; i <= n; i++ {
        dp[i] = dp[i-2]
        if i >= 3 {
            dp[i] = max(dp[i], dp[i-3])
        }
    }
    return dp[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}