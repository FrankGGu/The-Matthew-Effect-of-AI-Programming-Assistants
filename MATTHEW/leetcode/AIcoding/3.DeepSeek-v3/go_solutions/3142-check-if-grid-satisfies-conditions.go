func satisfiesConditions(grid [][]int) bool {
    rows := len(grid)
    cols := len(grid[0])

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if i < rows-1 && grid[i][j] != grid[i+1][j] {
                return false
            }
            if j < cols-1 && grid[i][j] == grid[i][j+1] {
                return false
            }
        }
    }
    return true
}