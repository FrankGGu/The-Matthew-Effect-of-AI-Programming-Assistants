func capturePoints(points [][]int) int {
    n := len(points)
    if n == 0 {
        return 0
    }

    m := len(points[0])
    if m == 0 {
        return 0
    }

    if n == 1 && m == 1 {
        return points[0][0]
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, m)
    }

    dp[0][0] = points[0][0]

    for i := 1; i < n; i++ {
        dp[i][0] = dp[i-1][0] + points[i][0]
    }

    for j := 1; j < m; j++ {
        dp[0][j] = dp[0][j-1] + points[0][j]
    }

    for i := 1; i < n; i++ {
        for j := 1; j < m; j++ {
            dp[i][j] = max(dp[i-1][j], dp[i][j-1]) + points[i][j]
        }
    }

    return dp[n-1][m-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}