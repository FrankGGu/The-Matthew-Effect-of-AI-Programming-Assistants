func findBall(grid [][]int) []int {
    m, n := len(grid), len(grid[0])
    result := make([]int, n)

    for j := 0; j < n; j++ {
        col := j
        for i := 0; i < m; i++ {
            if grid[i][col] == 1 {
                if col == n-1 || grid[i][col+1] == -1 {
                    col = -1
                    break
                }
                col++
            } else {
                if col == 0 || grid[i][col-1] == 1 {
                    col = -1
                    break
                }
                col--
            }
        }
        result[j] = col
    }
    return result
}