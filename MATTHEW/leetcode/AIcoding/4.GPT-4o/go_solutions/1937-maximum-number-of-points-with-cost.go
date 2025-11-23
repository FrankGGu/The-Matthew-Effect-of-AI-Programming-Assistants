func maxPoints(points [][]int) int {
    m, n := len(points), len(points[0])
    dp := make([]int, n)

    for i := 0; i < m; i++ {
        newDp := make([]int, n)
        maxLeft := 0
        for j := 0; j < n; j++ {
            maxLeft = max(maxLeft, dp[j] + j)
            newDp[j] = maxLeft - j + points[i][j]
        }

        maxRight := 0
        for j := n - 1; j >= 0; j-- {
            maxRight = max(maxRight, dp[j] - j)
            newDp[j] = max(newDp[j], maxRight + j + points[i][j])
        }
        dp = newDp
    }

    result := 0
    for _, v := range dp {
        result = max(result, v)
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}