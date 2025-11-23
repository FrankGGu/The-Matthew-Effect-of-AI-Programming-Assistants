func checkGrid(grid [][]int) bool {
    n := len(grid)
    m := len(grid[0])
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] != (i+1)*(j+1) {
                return false
            }
        }
    }
    return true
}