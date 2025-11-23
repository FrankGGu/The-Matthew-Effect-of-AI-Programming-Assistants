package main

func minDays(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    if countIslands(grid) != 1 {
        return 0
    }
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                grid[i][j] = 0
                if countIslands(grid) != 1 {
                    return 1
                }
                grid[i][j] = 1
            }
        }
    }
    return 2
}

func countIslands(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }
    count := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 && !visited[i][j] {
                dfs(grid, visited, i, j)
                count++
            }
        }
    }
    return count
}

func dfs(grid [][]int, visited [][]bool, i, j int) {
    if i < 0 || j < 0 || i >= len(grid) || j >= len(grid[0]) || grid[i][j] == 0 || visited[i][j] {
        return
    }
    visited[i][j] = true
    dfs(grid, visited, i+1, j)
    dfs(grid, visited, i-1, j)
    dfs(grid, visited, i, j+1)
    dfs(grid, visited, i, j-1)
}