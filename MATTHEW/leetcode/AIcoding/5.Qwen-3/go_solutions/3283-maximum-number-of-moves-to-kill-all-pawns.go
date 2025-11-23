package main

func maxMoves(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                dp[i][j] = 1
                if i > 0 && grid[i-1][j] == 0 {
                    dp[i][j] += dp[i-1][j]
                }
                if j > 0 && grid[i][j-1] == 0 {
                    dp[i][j] += dp[i][j-1]
                }
            }
        }
    }
    max := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if dp[i][j] > max {
                max = dp[i][j]
            }
        }
    }
    return max
}