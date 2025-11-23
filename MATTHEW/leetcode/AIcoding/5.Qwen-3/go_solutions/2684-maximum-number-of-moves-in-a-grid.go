package main

func maxMoves(grid [][]int) int {
    m := len(grid)
    n := len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    directions := [][]int{{-1, 1}, {0, 1}, {1, 1}}
    maxMove := 0

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if dp[i][j] == 0 {
                dfs(i, j, grid, dp, directions, 0)
            }
            maxMove = max(maxMove, dp[i][j])
        }
    }
    return maxMove
}

func dfs(i, j int, grid [][]int, dp [][]int, directions [][]int, steps int) int {
    if i < 0 || i >= len(grid) || j < 0 || j >= len(grid[0]) || dp[i][j] != 0 {
        return steps
    }
    maxSteps := steps
    for _, d := range directions {
        ni, nj := i+d[0], j+d[1]
        if ni >= 0 && ni < len(grid) && nj >= 0 && nj < len(grid[0]) && grid[ni][nj] > grid[i][j] {
            res := dfs(ni, nj, grid, dp, directions, steps+1)
            maxSteps = max(maxSteps, res)
        }
    }
    dp[i][j] = maxSteps
    return maxSteps
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}