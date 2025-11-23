func minimumCoins(prices []int) int {
    n := len(prices)
    dp := make([]int, n+1)

    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + prices[i-1]

        for j := max(0, i-i/2-1); j < i-1; j++ {
            dp[i] = min(dp[i], dp[j+1] + prices[i-1])
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

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}