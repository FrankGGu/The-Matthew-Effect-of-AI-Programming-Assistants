package main

func minSkips(costs []int, target int) int {
    n := len(costs)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    for i := 0; i <= n; i++ {
        for j := 0; j <= n; j++ {
            dp[i][j] = 1e9
        }
    }
    dp[0][0] = 0
    for i := 0; i < n; i++ {
        for j := 0; j <= i; j++ {
            if dp[i][j] == 1e9 {
                continue
            }
            // Skip current
            dp[i+1][j] = min(dp[i+1][j], dp[i][j]+costs[i])
            // Not skip current
            dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]+costs[i])
        }
    }
    for k := 0; k <= n; k++ {
        if dp[n][k] <= target {
            return k
        }
    }
    return -1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}