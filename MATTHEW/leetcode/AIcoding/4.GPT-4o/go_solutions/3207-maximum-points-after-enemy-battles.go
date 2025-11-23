func maxPoints(points []int) int {
    n := len(points)
    if n == 0 {
        return 0
    }
    dp := make([]int, n+1)
    dp[0] = 0
    dp[1] = points[0]

    for i := 1; i < n; i++ {
        dp[i+1] = max(dp[i], dp[i-1]+points[i])
    }

    return dp[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}