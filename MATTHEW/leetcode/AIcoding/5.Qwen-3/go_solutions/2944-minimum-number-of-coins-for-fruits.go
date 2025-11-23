package main

func minCoins(prices []int) int {
    n := len(prices)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = prices[i-1]
        for j := 1; j <= i/2; j++ {
            dp[i] = min(dp[i], dp[j]+dp[i-j])
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