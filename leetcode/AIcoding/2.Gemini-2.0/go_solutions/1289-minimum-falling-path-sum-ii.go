func minFallingPathSum(grid [][]int) int {
    n := len(grid)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        dp[0][i] = grid[0][i]
    }

    for i := 1; i < n; i++ {
        for j := 0; j < n; j++ {
            minVal := int(1e9)
            for k := 0; k < n; k++ {
                if k != j {
                    minVal = min(minVal, dp[i-1][k])
                }
            }
            dp[i][j] = grid[i][j] + minVal
        }
    }

    ans := int(1e9)
    for i := 0; i < n; i++ {
        ans = min(ans, dp[n-1][i])
    }

    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}