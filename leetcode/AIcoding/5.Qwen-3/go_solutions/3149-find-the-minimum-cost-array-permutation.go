package main

func minCostArrayPermutation(cost []int) int {
    n := len(cost)
    dp := make([]int, n)
    dp[0] = cost[0]
    for i := 1; i < n; i++ {
        dp[i] = dp[i-1] + cost[i]
    }
    return dp[n-1]
}