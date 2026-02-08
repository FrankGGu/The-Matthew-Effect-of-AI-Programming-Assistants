func maxPoints(points [][]int) int {
    m, n := len(points), len(points[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for j := 0; j < n; j++ {
        dp[0][j] = points[0][j]
    }

    for i := 1; i < m; i++ {
        left := make([]int, n)
        left[0] = dp[i-1][0]
        for j := 1; j < n; j++ {
            left[j] = max(left[j-1]-1, dp[i-1][j])
        }

        right := make([]int, n)
        right[n-1] = dp[i-1][n-1]
        for j := n-2; j >= 0; j-- {
            right[j] = max(right[j+1]-1, dp[i-1][j])
        }

        for j := 0; j < n; j++ {
            dp[i][j] = max(left[j], right[j]) + points[i][j]
        }
    }

    maxVal := 0
    for j := 0; j < n; j++ {
        if dp[m-1][j] > maxVal {
            maxVal = dp[m-1][j]
        }
    }
    return maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}