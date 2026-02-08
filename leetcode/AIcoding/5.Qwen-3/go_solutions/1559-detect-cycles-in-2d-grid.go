package main

func containsCycle(grid []string, k int) bool {
    rows, cols := len(grid), len(grid[0])
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }

    var dfs func(i, j, prevI, prevJ int, color int) bool
    dfs = func(i, j, prevI, prevJ int, color int) bool {
        if i < 0 || i >= rows || j < 0 || j >= cols {
            return false
        }
        if visited[i][j] {
            return i != prevI || j != prevJ
        }
        visited[i][j] = true
        if grid[i][j] == byte(k) {
            return true
        }
        if dfs(i+1, j, i, j, color) ||
           dfs(i-1, j, i, j, color) ||
           dfs(i, j+1, i, j, color) ||
           dfs(i, j-1, i, j, color) {
            return true
        }
        return false
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if !visited[i][j] && dfs(i, j, -1, -1, 0) {
                return true
            }
        }
    }
    return false
}

func containsCycle(grid []string) bool {
    return containsCycle(grid, 0)
}