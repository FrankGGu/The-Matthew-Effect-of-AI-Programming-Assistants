func calculateRegionAverage(grid [][]int, row int, col int, k int) float64 {
    total, count := 0, 0
    rows, cols := len(grid), len(grid[0])

    for i := max(0, row-k); i <= min(rows-1, row+k); i++ {
        for j := max(0, col-k); j <= min(cols-1, col+k); j++ {
            if abs(i-row)+abs(j-col) <= k {
                total += grid[i][j]
                count++
            }
        }
    }

    return float64(total) / float64(count)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func findRegionAverage(grid [][]int, k int) [][]float64 {
    rows, cols := len(grid), len(grid[0])
    result := make([][]float64, rows)

    for i := range result {
        result[i] = make([]float64, cols)
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            result[i][j] = calculateRegionAverage(grid, i, j, k)
        }
    }

    return result
}