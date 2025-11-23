func maxPoints(points [][]int) int64 {
    m := len(points)
    if m == 0 {
        return 0
    }
    n := len(points[0])
    if n == 0 {
        return 0
    }

    dp := make([][]int64, m)
    for i := range dp {
        dp[i] = make([]int64, n)
    }

    for j := 0; j < n; j++ {
        dp[0][j] = int64(points[0][j])
    }

    for i := 1; i < m; i++ {
        left := make([]int64, n)
        left[0] = dp[i-1][0]
        for j := 1; j < n; j++ {
            left[j] = max(left[j-1]-1, dp[i-1][j])
        }

        right := make([]int64, n)
        right[n-1] = dp[i-1][n-1]
        for j := n-2; j >= 0; j-- {
            right[j] = max(right[j+1]-1, dp[i-1][j])
        }

        for j := 0; j < n; j++ {
            dp[i][j] = max(left[j], right[j]) + int64(points[i][j])
        }
    }

    var res int64
    for j := 0; j < n; j++ {
        res = max(res, dp[m-1][j])
    }
    return res
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}