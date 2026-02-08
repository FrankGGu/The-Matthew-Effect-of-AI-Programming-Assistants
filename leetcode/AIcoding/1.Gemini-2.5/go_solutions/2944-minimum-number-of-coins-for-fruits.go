func minimumCoins(prices []int) int {
    n := len(prices)
    if n == 0 {
        return 0
    }

    dp := make([]int, n+2)

    for i := n - 1; i >= 0; i-- {
        dp[i] = prices[i] + dp[i+2]
    }

    return dp[0]
}