package main

func maxProfit(k int, prices []int) int {
    if k >= len(prices)/2 {
        profit := 0
        for i := 1; i < len(prices); i++ {
            if prices[i] > prices[i-1] {
                profit += prices[i] - prices[i-1]
            }
        }
        return profit
    }

    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, len(prices))
    }

    for i := 1; i <= k; i++ {
        maxDiff := -prices[0]
        for j := 1; j < len(prices); j++ {
            dp[i][j] = max(dp[i][j-1], prices[j]+maxDiff)
            maxDiff = max(maxDiff, dp[i-1][j]-prices[j])
        }
    }

    return dp[k][len(prices)-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}