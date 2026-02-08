func maxPoints(points [][]int) int {
    n := len(points)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    dp[0] = points[0][1]
    maxPoints := dp[0]

    for i := 1; i < n; i++ {
        dp[i] = points[i][1]
        for j := 0; j < i; j++ {
            if points[j][0] + points[j][1] >= points[i][0] {
                dp[i] = max(dp[i], dp[j] + points[i][1])
            }
        }
        maxPoints = max(maxPoints, dp[i])
    }

    return maxPoints
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}