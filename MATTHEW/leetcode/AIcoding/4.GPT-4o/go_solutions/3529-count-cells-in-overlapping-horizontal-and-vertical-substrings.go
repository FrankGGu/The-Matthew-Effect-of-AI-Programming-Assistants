func countCells(grid [][]byte) int {
    m, n := len(grid), len(grid[0])
    rows := make([]int, m)
    cols := make([]int, n)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == '1' {
                rows[i]++
                cols[j]++
            }
        }
    }

    count := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == '1' {
                count += (rows[i] - 1) + (cols[j] - 1)
            }
        }
    }

    return count
}