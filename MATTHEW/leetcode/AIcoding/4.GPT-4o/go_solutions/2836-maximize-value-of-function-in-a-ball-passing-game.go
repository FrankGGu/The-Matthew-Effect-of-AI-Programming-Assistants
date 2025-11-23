func maxValue(n int, passes [][]int) int {
    dp := make([]int, n+1)
    for _, pass := range passes {
        from, to, value := pass[0], pass[1], pass[2]
        dp[to] = max(dp[to], dp[from]+value)
    }
    maxValue := 0
    for _, v := range dp {
        maxValue = max(maxValue, v)
    }
    return maxValue
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}