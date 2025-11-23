func countPyramids(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    res := 0

    for i := m - 1; i >= 0; i-- {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                dp[i][j] = 0
                continue
            }
            if i == m - 1 || j == 0 || j == n - 1 {
                dp[i][j] = 1
                continue
            }
            dp[i][j] = min(dp[i+1][j-1], min(dp[i+1][j], dp[i+1][j+1])) + 1
            res += dp[i][j] - 1
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                dp[i][j] = 0
                continue
            }
            if i == 0 || j == 0 || j == n - 1 {
                dp[i][j] = 1
                continue
            }
            dp[i][j] = min(dp[i-1][j-1], min(dp[i-1][j], dp[i-1][j+1])) + 1
            res += dp[i][j] - 1
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}