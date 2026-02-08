package main

func isGridPossible(grid [][]int) bool {
    m, n := len(grid), len(grid[0])
    directions := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    var dfs func(i, j int, prev int) bool
    dfs = func(i, j, prev int) bool {
        if i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || grid[i][j] == 0 {
            return false
        }
        visited[i][j] = true
        for _, d := range directions {
            ni, nj := i+d[0], j+d[1]
            if ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj] && grid[ni][nj] != 0 {
                if grid[ni][nj] == 1 {
                    if prev == 2 {
                        return false
                    }
                } else if grid[ni][nj] == 2 {
                    if prev == 1 {
                        return false
                    }
                }
                if !dfs(ni, nj, grid[ni][nj]) {
                    return false
                }
            }
        }
        return true
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] != 0 && !visited[i][j] {
                if !dfs(i, j, 0) {
                    return false
                }
            }
        }
    }
    return true
}