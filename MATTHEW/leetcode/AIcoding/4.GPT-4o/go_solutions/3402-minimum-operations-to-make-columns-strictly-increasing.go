func minOperations(grid [][]int) int {
    row, col := len(grid), len(grid[0])
    ops := 0
    for i := row - 1; i > 0; i-- {
        for j := 0; j < col; j++ {
            if grid[i][j] <= grid[i-1][j] {
                ops += grid[i-1][j] - grid[i][j] + 1
                grid[i-1][j] = grid[i][j] - 1
            }
        }
    }
    return ops
}