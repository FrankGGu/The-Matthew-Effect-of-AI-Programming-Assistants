func containsCycle(grid [][]byte) bool {
    rows, cols := len(grid), len(grid[0])
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }

    var dfs func(r, c, pr, pc int, color byte) bool
    dfs = func(r, c, pr, pc int, color byte) bool {
        if visited[r][c] {
            return true
        }
        visited[r][c] = true
        directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
        for _, dir := range directions {
            nr, nc := r+dir[0], c+dir[1]
            if nr >= 0 && nr < rows && nc >= 0 && nc < cols && !(nr == pr && nc == pc) && grid[nr][nc] == color {
                if dfs(nr, nc, r, c, color) {
                    return true
                }
            }
        }
        return false
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if !visited[i][j] && dfs(i, j, -1, -1, grid[i][j]) {
                return true
            }
        }
    }
    return false
}