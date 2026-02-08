func colorBorder(grid [][]int, row int, col int, color int) [][]int {
    originalColor := grid[row][col]
    if originalColor == color {
        return grid
    }

    directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    border := make(map[[2]int]bool)
    visited := make(map[[2]int]bool)

    var dfs func(r, c int)
    dfs = func(r, c int) {
        visited[[2]int{r, c}] = true
        isBorder := false

        for _, dir := range directions {
            nr, nc := r+dir[0], c+dir[1]
            if nr < 0 || nr >= len(grid) || nc < 0 || nc >= len(grid[0]) {
                isBorder = true
                continue
            }
            if grid[nr][nc] != originalColor {
                isBorder = true
            } else if !visited[[2]int{nr, nc}] {
                dfs(nr, nc)
            }
        }

        if isBorder {
            border[[2]int{r, c}] = true
        }
    }

    dfs(row, col)

    for pos := range border {
        grid[pos[0]][pos[1]] = color
    }

    for r := 0; r < len(grid); r++ {
        for c := 0; c < len(grid[0]); c++ {
            if grid[r][c] == originalColor {
                grid[r][c] = originalColor
            }
        }
    }

    return grid
}