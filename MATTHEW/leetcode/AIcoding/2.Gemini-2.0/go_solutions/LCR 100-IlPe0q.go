func minimumTotal(triangle [][]int) int {
    n := len(triangle)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = triangle[n-1][i]
    }

    for i := n - 2; i >= 0; i-- {
        for j := 0; j <= i; j++ {
            dp[j] = min(dp[j], dp[j+1]) + triangle[i][j]
        }
    }

    return dp[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}