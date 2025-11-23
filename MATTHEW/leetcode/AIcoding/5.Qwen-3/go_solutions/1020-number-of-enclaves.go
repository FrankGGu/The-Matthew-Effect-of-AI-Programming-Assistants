package main

func numEnclaves(grid [][]int) int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return 0
    }

    rows, cols := len(grid), len(grid[0])

    // Mark all land connected to the border
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if (i == 0 || i == rows-1 || j == 0 || j == cols-1) && grid[i][j] == 1 {
                dfs(grid, i, j)
            }
        }
    }

    // Count remaining land
    count := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                count++
            }
        }
    }

    return count
}

func dfs(grid [][]int, i, j int) {
    if i < 0 || i >= len(grid) || j < 0 || j >= len(grid[0]) || grid[i][j] == 0 {
        return
    }
    grid[i][j] = 0
    dfs(grid, i+1, j)
    dfs(grid, i-1, j)
    dfs(grid, i, j+1)
    dfs(grid, i, j-1)
}