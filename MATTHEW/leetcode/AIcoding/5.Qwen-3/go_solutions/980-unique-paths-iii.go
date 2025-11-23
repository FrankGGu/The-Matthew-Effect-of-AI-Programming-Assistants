package main

func uniquePathsIII(grid [][]int) int {
    var startRow, startCol int
    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] == 1 {
                startRow, startCol = i, j
            }
        }
    }

    visited := make([][]bool, len(grid))
    for i := range visited {
        visited[i] = make([]bool, len(grid[0]))
    }

    var result int
    dfs(startRow, startCol, grid, visited, 0, &result)
    return result
}

func dfs(r, c int, grid [][]int, visited [][]bool, steps int, result *int) {
    if grid[r][c] == 2 {
        if steps == 0 {
            *result++
        }
        return
    }

    visited[r][c] = true
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for _, dir := range directions {
        nr, nc := r+dir[0], c+dir[1]
        if nr >= 0 && nr < len(grid) && nc >= 0 && nc < len(grid[0]) && !visited[nr][nc] && grid[nr][nc] != -1 {
            dfs(nr, nc, grid, visited, steps-1, result)
        }
    }
    visited[r][c] = false
}