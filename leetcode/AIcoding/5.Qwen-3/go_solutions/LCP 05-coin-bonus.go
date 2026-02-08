package main

func maxPoints(operations []int) int {
    n := len(operations)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = operations[i]
        if i > 0 {
            dp[i] = max(dp[i], dp[i-1])
        }
        if i > 1 {
            dp[i] = max(dp[i], dp[i-2])
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