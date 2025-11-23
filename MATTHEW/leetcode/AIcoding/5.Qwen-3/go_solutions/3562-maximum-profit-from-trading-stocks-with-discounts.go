package main

func maxProfit(prices []int, n int) int {
    if n == 0 {
        return 0
    }
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = prices[i]
        for j := 0; j < i; j++ {
            if prices[i] > prices[j] {
                dp[i] = max(dp[i], dp[j]+prices[i]-prices[j])
            } else {
                dp[i] = max(dp[i], dp[j])
            }
        }
    }
    return dp[n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}