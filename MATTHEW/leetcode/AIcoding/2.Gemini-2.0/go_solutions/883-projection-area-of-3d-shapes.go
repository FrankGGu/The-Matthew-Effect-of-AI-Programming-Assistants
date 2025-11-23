func projectionArea(grid [][]int) int {
    n := len(grid)
    xy := 0
    xz := 0
    yz := 0

    for i := 0; i < n; i++ {
        maxRow := 0
        maxCol := 0
        for j := 0; j < n; j++ {
            if grid[i][j] > 0 {
                xy++
            }
            if grid[i][j] > maxRow {
                maxRow = grid[i][j]
            }
            if grid[j][i] > maxCol {
                maxCol = grid[j][i]
            }
        }
        xz += maxRow
        yz += maxCol
    }

    return xy + xz + yz
}