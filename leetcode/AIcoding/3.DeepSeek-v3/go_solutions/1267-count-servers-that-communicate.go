func countServers(grid [][]int) int {
    rows := make([]int, len(grid))
    cols := make([]int, len(grid[0]))

    for i := range grid {
        for j := range grid[i] {
            if grid[i][j] == 1 {
                rows[i]++
                cols[j]++
            }
        }
    }

    res := 0
    for i := range grid {
        for j := range grid[i] {
            if grid[i][j] == 1 && (rows[i] > 1 || cols[j] > 1) {
                res++
            }
        }
    }

    return res
}