func maxProfit(prices []int, fee int, discount int) int {
    n := len(prices)
    if n == 0 {
        return 0
    }

    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 2)
    }

    dp[0][0] = 0
    dp[0][1] = -1000000000

    for i := 1; i <= n; i++ {
        dp[i][0] = max(dp[i-1][0], dp[i-1][1]+prices[i-1]-fee)
        dp[i][1] = max(dp[i-1][1], dp[i-1][0]-prices[i-1]-discount)
    }

    return dp[n][0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}