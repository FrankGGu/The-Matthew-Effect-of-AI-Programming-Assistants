func fillGrid(grid [][]int) [][]int {
    m, n := len(grid), len(grid[0])
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                for num := 1; num <= 4; num++ {
                    valid := true
                    if i > 0 && grid[i-1][j] == num {
                        valid = false
                    }
                    if i < m-1 && grid[i+1][j] == num {
                        valid = false
                    }
                    if j > 0 && grid[i][j-1] == num {
                        valid = false
                    }
                    if j < n-1 && grid[i][j+1] == num {
                        valid = false
                    }
                    if valid {
                        grid[i][j] = num
                        break
                    }
                }
            }
        }
    }
    return grid
}