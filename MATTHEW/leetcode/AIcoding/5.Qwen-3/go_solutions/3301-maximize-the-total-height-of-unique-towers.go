package main

func maximumTotalHeight(towers []int) int {
    n := len(towers)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = towers[i]
        if i > 0 {
            dp[i] = max(dp[i], dp[i-1]+towers[i])
        }
        if i > 1 {
            dp[i] = max(dp[i], dp[i-2]+towers[i])
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