func numberOfRightTriangles(grid [][]int) int64 {
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])

    rowCount := make([]int, rows)
    colCount := make([]int, cols)

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                rowCount[i]++
                colCount[j]++
            }
        }
    }

    var res int64 = 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                res += int64((rowCount[i] - 1) * (colCount[j] - 1))
            }
        }
    }

    return res
}