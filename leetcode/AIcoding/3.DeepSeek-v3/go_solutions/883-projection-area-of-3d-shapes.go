func projectionArea(grid [][]int) int {
    n := len(grid)
    xy, yz, zx := 0, 0, 0
    for i := 0; i < n; i++ {
        maxRow, maxCol := 0, 0
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
        yz += maxRow
        zx += maxCol
    }
    return xy + yz + zx
}