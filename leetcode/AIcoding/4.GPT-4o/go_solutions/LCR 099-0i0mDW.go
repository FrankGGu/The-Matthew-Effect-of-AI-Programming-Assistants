func minPathSum(grid [][]int) int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return 0
    }

    rows := len(grid)
    cols := len(grid[0])

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if i == 0 && j == 0 {
                continue
            }
            if i == 0 {
                grid[i][j] += grid[i][j-1]
            } else if j == 0 {
                grid[i][j] += grid[i-1][j]
            } else {
                grid[i][j] += min(grid[i-1][j], grid[i][j-1])
            }
        }
    }

    return grid[rows-1][cols-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}