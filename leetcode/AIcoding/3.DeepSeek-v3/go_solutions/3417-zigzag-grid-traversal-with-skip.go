func traverseGrid(grid [][]int, skip int) []int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return []int{}
    }
    rows, cols := len(grid), len(grid[0])
    result := make([]int, 0)
    for i := 0; i < rows+cols-1; i++ {
        if i%skip == 0 {
            continue
        }
        if i%2 == 0 {
            x := min(i, rows-1)
            y := i - x
            for x >= 0 && y < cols {
                result = append(result, grid[x][y])
                x--
                y++
            }
        } else {
            y := min(i, cols-1)
            x := i - y
            for y >= 0 && x < rows {
                result = append(result, grid[x][y])
                x++
                y--
            }
        }
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}