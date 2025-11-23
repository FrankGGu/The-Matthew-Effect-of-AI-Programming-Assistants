func countUnguardedCells(m int, n int, guards [][]int, walls [][]int) int {
    grid := make([][]int, m)
    for i := range grid {
        grid[i] = make([]int, n)
    }

    for _, g := range guards {
        grid[g[0]][g[1]] = 1
    }
    for _, w := range walls {
        grid[w[0]][w[1]] = -1
    }

    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for _, g := range guards {
        for _, d := range directions {
            x, y := g[0], g[1]
            for {
                x += d[0]
                y += d[1]
                if x < 0 || x >= m || y < 0 || y >= n || grid[x][y] == -1 {
                    break
                }
                grid[x][y] = 1
            }
        }
    }

    count := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                count++
            }
        }
    }

    return count
}