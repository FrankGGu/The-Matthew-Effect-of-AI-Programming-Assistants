func minOperations(grid [][]int) int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return 0
    }
    m, n := len(grid), len(grid[0])
    res := 0
    for j := 0; j < n; j++ {
        for i := 1; i < m; i++ {
            if grid[i][j] <= grid[i-1][j] {
                diff := grid[i-1][j] - grid[i][j] + 1
                grid[i][j] += diff
                res += diff
            }
        }
    }
    return res
}