package main

func maxFish(grid [][]int) int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return 0
    }

    rows, cols := len(grid), len(grid[0])
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i < 0 || i >= rows || j < 0 || j >= cols || visited[i][j] || grid[i][j] == 0 {
            return 0
        }
        visited[i][j] = true
        return grid[i][j] + dfs(i+1, j) + dfs(i-1, j) + dfs(i, j+1) + dfs(i, j-1)
    }

    max := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if !visited[i][j] && grid[i][j] > 0 {
                current := dfs(i, j)
                if current > max {
                    max = current
                }
            }
        }
    }
    return max
}