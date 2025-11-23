package main

func minCostClimbingStairs(cost []int) int {
    n := len(cost)
    for i := 2; i < n; i++ {
        cost[i] += min(cost[i-1], cost[i-2])
    }
    return min(cost[n-1], cost[n-2])
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}