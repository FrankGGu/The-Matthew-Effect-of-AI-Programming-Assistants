package main

func maxPriceSum(prices []int, k int) int {
    n := len(prices)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }

    for i := 0; i < n; i++ {
        for j := 0; j <= k; j++ {
            if j == 0 {
                dp[i][j] = prices[i]
            } else {
                dp[i][j] = prices[i]
                for m := 0; m < i; m++ {
                    dp[i][j] = max(dp[i][j], dp[m][j-1]+prices[i])
                }
            }
        }
    }

    res := 0
    for i := 0; i < n; i++ {
        res = max(res, dp[i][k])
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}