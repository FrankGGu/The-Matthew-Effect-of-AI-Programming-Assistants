func colorBorder(grid [][]int, row int, col int, color int) [][]int {
    originalColor := grid[row][col]
    if originalColor == color {
        return grid
    }
    m, n := len(grid), len(grid[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    var dfs func(int, int)
    dfs = func(r, c int) {
        if r < 0 || r >= m || c < 0 || c >= n || grid[r][c] != originalColor || visited[r][c] {
            return
        }
        visited[r][c] = true
        isBorder := false
        for _, dir := range dirs {
            nr, nc := r+dir[0], c+dir[1]
            if nr < 0 || nr >= m || nc < 0 || nc >= n || grid[nr][nc] != originalColor {
                isBorder = true
                break
            }
        }
        if isBorder {
            grid[r][c] = color
        }
        for _, dir := range dirs {
            dfs(r+dir[0], c+dir[1])
        }
    }
    dfs(row, col)
    return grid
}