func findBall(grid [][]int) []int {
    m := len(grid)
    n := len(grid[0])
    result := make([]int, n)

    for i := 0; i < n; i++ {
        col := i
        for row := 0; row < m; row++ {
            if grid[row][col] == 1 {
                if col == n-1 || grid[row][col+1] == -1 {
                    col = -1
                    break
                }
                col++
            } else {
                if col == 0 || grid[row][col-1] == 1 {
                    col = -1
                    break
                }
                col--
            }
        }
        result[i] = col
    }

    return result
}