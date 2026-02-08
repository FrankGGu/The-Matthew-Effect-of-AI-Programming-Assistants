func maxIncreaseKeepingSkyline(grid [][]int) int {
    n := len(grid)
    rowMax := make([]int, n)
    colMax := make([]int, n)

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] > rowMax[i] {
                rowMax[i] = grid[i][j]
            }
            if grid[i][j] > colMax[j] {
                colMax[j] = grid[i][j]
            }
        }
    }

    totalIncrease := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            totalIncrease += min(rowMax[i], colMax[j]) - grid[i][j]
        }
    }

    return totalIncrease
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}