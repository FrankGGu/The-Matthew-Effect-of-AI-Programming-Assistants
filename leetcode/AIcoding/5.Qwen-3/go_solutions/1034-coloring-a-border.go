package main

func colorBorder(grid [][]int, x int, y int, color int) [][]int {
    originalColor := grid[x][y]
    if originalColor == color {
        return grid
    }
    rows, cols := len(grid), len(grid[0])
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }
    var dfs func(int, int)
    dfs = func(r, c int) {
        visited[r][c] = true
        directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
        for _, d := range directions {
            nr, nc := r+d[0], c+d[1]
            if nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] == originalColor {
                if !visited[nr][nc] {
                    dfs(nr, nc)
                }
            } else {
                grid[r][c] = color
            }
        }
    }
    dfs(x, y)
    return grid
}