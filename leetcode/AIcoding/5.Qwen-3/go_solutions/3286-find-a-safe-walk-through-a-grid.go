package main

func isSafeWalk(grid [][]int, health int) bool {
    m, n := len(grid), len(grid[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    var dfs func(i, j, h int) bool
    dfs = func(i, j, h int) bool {
        if i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || grid[i][j] > h {
            return false
        }
        if i == m-1 && j == n-1 {
            return true
        }
        visited[i][j] = true
        if dfs(i+1, j, h-grid[i][j]) || dfs(i-1, j, h-grid[i][j]) || dfs(i, j+1, h-grid[i][j]) || dfs(i, j-1, h-grid[i][j]) {
            return true
        }
        visited[i][j] = false
        return false
    }
    return dfs(0, 0, health)
}