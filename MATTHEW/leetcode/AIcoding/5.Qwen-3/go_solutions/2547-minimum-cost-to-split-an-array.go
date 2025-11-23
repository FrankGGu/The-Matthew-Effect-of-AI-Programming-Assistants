package main

func minCost(arr []int, cost []int) int {
    n := len(arr)
    if n == 1 {
        return 0
    }
    dp := make([]int, n)
    for i := 1; i < n; i++ {
        dp[i] = dp[i-1] + cost[i]
    }
    for i := 2; i < n; i++ {
        for j := 1; j < i; j++ {
            if arr[j] > arr[j-1] && arr[i] > arr[i-1] {
                dp[i] = min(dp[i], dp[j-1]+cost[i])
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