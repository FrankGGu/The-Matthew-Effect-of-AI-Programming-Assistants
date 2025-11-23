func countNegatives(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    count := 0
    for i := 0; i < m; i++ {
        for j := n - 1; j >= 0; j-- {
            if grid[i][j] < 0 {
                count++
            } else {
                break
            }
        }
    }
    return count
}