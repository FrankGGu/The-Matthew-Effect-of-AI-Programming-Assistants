package main

func minTransportationCost(boxes []int, cost []int) int {
    n := len(boxes)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = cost[i]
        for j := 0; j < i; j++ {
            if boxes[j] == boxes[i] {
                dp[i] = min(dp[i], dp[j]+cost[i])
            }
        }
    }
    return dp[n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}