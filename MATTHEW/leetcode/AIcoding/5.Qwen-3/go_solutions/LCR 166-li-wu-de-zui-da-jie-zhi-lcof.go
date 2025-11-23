package main

func jewelleryValue(grid [][]int) int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return 0
    }
    m, n := len(grid), len(grid[0])
    for i := 1; i < m; i++ {
        grid[i][0] += grid[i-1][0]
    }
    for j := 1; j < n; j++ {
        grid[0][j] += grid[0][j-1]
    }
    for i := 1; i < m; i++ {
        for j := 1; j < n; j++ {
            grid[i][j] += max(grid[i-1][j], grid[i][j-1])
        }
    }
    return grid[m-1][n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}