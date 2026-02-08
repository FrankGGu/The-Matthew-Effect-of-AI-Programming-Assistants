package main

func minCostToPaintWalls(cost []int, time []int) int {
    n := len(cost)
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = 1000000000
    }
    dp[0] = 0
    for i := 0; i < n; i++ {
        for j := n; j >= 0; j-- {
            if j+time[i] < n {
                dp[j+time[i]] = min(dp[j+time[i]], dp[j]+cost[i])
            } else {
                dp[n] = min(dp[n], dp[j]+cost[i])
            }
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