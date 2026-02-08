func maxProductPath(grid [][]int) int {
    mod := int(1e9 + 7)
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    minDp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
        minDp[i] = make([]int, n)
    }

    dp[0][0] = grid[0][0]
    minDp[0][0] = grid[0][0]

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if i == 0 && j == 0 {
                continue
            }
            if i > 0 {
                dp[i][j] = max(dp[i][j], dp[i-1][j]*grid[i][j])
                minDp[i][j] = min(minDp[i][j], minDp[i-1][j]*grid[i][j])
            }
            if j > 0 {
                dp[i][j] = max(dp[i][j], dp[i][j-1]*grid[i][j])
                minDp[i][j] = min(minDp[i][j], minDp[i][j-1]*grid[i][j])
            }
            if grid[i][j] < 0 {
                dp[i][j], minDp[i][j] = minDp[i][j], dp[i][j]
            }
        }
    }

    if dp[m-1][n-1] < 0 {
        return -1
    }
    return dp[m-1][n-1] % mod
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}