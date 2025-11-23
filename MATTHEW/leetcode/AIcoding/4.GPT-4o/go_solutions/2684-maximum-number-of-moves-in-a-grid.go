func maxMoves(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for j := 0; j < n; j++ {
        dp[0][j] = 1
    }

    for i := 1; i < m; i++ {
        for j := 0; j < n; j++ {
            for k := -1; k <= 1; k++ {
                nj := j + k
                if nj >= 0 && nj < n && grid[i][j] > grid[i-1][nj] {
                    dp[i][j] = max(dp[i][j], dp[i-1][nj]+1)
                }
            }
        }
    }

    maxMoves := 0
    for j := 0; j < n; j++ {
        maxMoves = max(maxMoves, dp[m-1][j])
    }

    return maxMoves
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}