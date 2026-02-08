func minimumCoins(prices []int) int {
    n := len(prices)
    dp := make([]int, n+2)
    for i := n; i >= 1; i-- {
        minCost := math.MaxInt32
        for j := i + 1; j <= min(2*i+1, n+1); j++ {
            if dp[j] < minCost {
                minCost = dp[j]
            }
        }
        if minCost == math.MaxInt32 {
            dp[i] = prices[i-1]
        } else {
            dp[i] = prices[i-1] + minCost
        }
    }
    return dp[1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}