func countPyramids(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    count := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                dp[i][j] = 1
                if i > 0 && j > 0 {
                    dp[i][j] += min(dp[i-1][j-1], min(dp[i-1][j], dp[i][j-1]))
                }
                count += dp[i][j]
            }
        }
    }
    return count
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}