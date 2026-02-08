func countServers(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    rowCount, colCount := make([]int, rows), make([]int, cols)

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                rowCount[i]++
                colCount[j]++
            }
        }
    }

    count := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 && (rowCount[i] > 1 || colCount[j] > 1) {
                count++
            }
        }
    }

    return count
}