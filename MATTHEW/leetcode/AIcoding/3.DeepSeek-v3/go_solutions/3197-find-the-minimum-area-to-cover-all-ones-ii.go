func minimumArea(grid [][]int) int {
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])
    if cols == 0 {
        return 0
    }

    minRow, maxRow := rows, -1
    minCol, maxCol := cols, -1

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                if i < minRow {
                    minRow = i
                }
                if i > maxRow {
                    maxRow = i
                }
                if j < minCol {
                    minCol = j
                }
                if j > maxCol {
                    maxCol = j
                }
            }
        }
    }

    if minRow == rows {
        return 0
    }

    return (maxRow - minRow + 1) * (maxCol - minCol + 1)
}