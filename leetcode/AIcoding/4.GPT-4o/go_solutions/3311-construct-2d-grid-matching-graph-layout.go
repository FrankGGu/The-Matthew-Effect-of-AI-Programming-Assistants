func constructGrid(m int, n int) [][]int {
    grid := make([][]int, m)
    for i := range grid {
        grid[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            grid[i][j] = i * n + j
        }
    }

    return grid
}