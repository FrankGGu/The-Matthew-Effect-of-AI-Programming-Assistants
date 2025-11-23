func countCells(grid []string) int {
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])

    rowHasHorizontal := make([]bool, rows)
    colHasVertical := make([]bool, cols)

    for i := 0; i < rows; i++ {
        for j := 0; j < cols-2; j++ {
            if grid[i][j] == 'H' && grid[i][j+1] == 'H' && grid[i][j+2] == 'H' {
                rowHasHorizontal[i] = true
                break
            }
        }
    }

    for j := 0; j < cols; j++ {
        for i := 0; i < rows-2; i++ {
            if grid[i][j] == 'V' && grid[i+1][j] == 'V' && grid[i+2][j] == 'V' {
                colHasVertical[j] = true
                break
            }
        }
    }

    count := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if rowHasHorizontal[i] && colHasVertical[j] {
                count++
            }
        }
    }

    return count
}