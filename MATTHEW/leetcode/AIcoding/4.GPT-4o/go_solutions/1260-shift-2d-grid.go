func shiftGrid(grid [][]int, k int) [][]int {
    rows, cols := len(grid), len(grid[0])
    k = k % (rows * cols)
    if k == 0 {
        return grid
    }

    flat := make([]int, rows * cols)
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            flat[i * cols + j] = grid[i][j]
        }
    }

    newFlat := make([]int, len(flat))
    copy(newFlat, flat[len(flat) - k:])
    copy(newFlat[k:], flat[:len(flat) - k])

    result := make([][]int, rows)
    for i := 0; i < rows; i++ {
        result[i] = newFlat[i * cols:(i + 1) * cols]
    }

    return result
}