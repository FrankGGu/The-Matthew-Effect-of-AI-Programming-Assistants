func maxProfit(prices []int) int {
    if len(prices) <= 1 {
        return 0
    }

    n := len(prices)
    dp := make([][2]int, n)

    dp[0][0] = 0
    dp[0][1] = -prices[0]
    dp[1][0] = max(dp[0][0], dp[0][1]+prices[1])
    dp[1][1] = max(dp[0][1], dp[0][0]-prices[1])

    for i := 2; i < n; i++ {
        dp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i])
        dp[i][1] = max(dp[i-1][1], dp[i-2][0]-prices[i])
    }

    return dp[n-1][0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}