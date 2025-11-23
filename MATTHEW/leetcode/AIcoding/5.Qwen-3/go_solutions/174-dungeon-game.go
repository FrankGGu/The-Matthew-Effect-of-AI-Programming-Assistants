package main

func calculateMinimumHP(grid [][]int) int {
    m := len(grid)
    n := len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    if grid[m-1][n-1] >= 0 {
        dp[m-1][n-1] = 1
    } else {
        dp[m-1][n-1] = -grid[m-1][n-1] + 1
    }
    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if i == m-1 && j == n-1 {
                continue
            }
            if i == m-1 {
                dp[i][j] = dp[i][j+1] - grid[i][j]
            } else if j == n-1 {
                dp[i][j] = dp[i+1][j] - grid[i][j]
            } else {
                dp[i][j] = min(dp[i+1][j], dp[i][j+1]) - grid[i][j]
            }
            if dp[i][j] <= 0 {
                dp[i][j] = 1
            }
        }
    }
    return dp[0][0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}