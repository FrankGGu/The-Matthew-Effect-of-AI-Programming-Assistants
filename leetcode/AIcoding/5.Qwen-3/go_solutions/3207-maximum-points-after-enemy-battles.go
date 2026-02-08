package main

func maxPoints(enemies []int) int {
    dp := make([]int, 1001)
    for _, e := range enemies {
        dp[e] = max(dp[e-1]+e, dp[e])
    }
    return dp[1000]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}