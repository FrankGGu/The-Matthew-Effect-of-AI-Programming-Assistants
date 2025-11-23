package main

func isPossible(grid [][]int) bool {
    m, n := len(grid), len(grid[0])

    var dfs func(i, j int, path map[int]bool) bool
    dfs = func(i, j int, path map[int]bool) bool {
        if i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == 0 {
            return false
        }
        if i == m-1 && j == n-1 {
            return true
        }
        key := i*n + j
        if path[key] {
            return false
        }
        path[key] = true
        if dfs(i+1, j, path) || dfs(i-1, j, path) || dfs(i, j+1, path) || dfs(i, j-1, path) {
            return true
        }
        delete(path, key)
        return false
    }

    if !dfs(0, 0, make(map[int]bool)) {
        return false
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                grid[i][j] = 1
                if !dfs(0, 0, make(map[int]bool)) {
                    grid[i][j] = 0
                    return true
                }
                grid[i][j] = 0
            }
        }
    }

    return false
}