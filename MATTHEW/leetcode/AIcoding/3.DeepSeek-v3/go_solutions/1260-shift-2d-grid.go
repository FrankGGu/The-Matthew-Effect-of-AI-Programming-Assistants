func shiftGrid(grid [][]int, k int) [][]int {
    m, n := len(grid), len(grid[0])
    total := m * n
    k %= total
    if k == 0 {
        return grid
    }

    flat := make([]int, 0, total)
    for _, row := range grid {
        flat = append(flat, row...)
    }

    shifted := make([]int, total)
    copy(shifted[k:], flat[:total-k])
    copy(shifted[:k], flat[total-k:])

    res := make([][]int, m)
    for i := 0; i < m; i++ {
        res[i] = make([]int, n)
        for j := 0; j < n; j++ {
            res[i][j] = shifted[i*n + j]
        }
    }
    return res
}