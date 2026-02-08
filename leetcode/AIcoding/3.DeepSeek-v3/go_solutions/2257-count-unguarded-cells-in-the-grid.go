func countUnguarded(m int, n int, guards [][]int, walls [][]int) int {
    grid := make([][]int, m)
    for i := range grid {
        grid[i] = make([]int, n)
    }

    for _, wall := range walls {
        grid[wall[0]][wall[1]] = 2
    }

    for _, guard := range guards {
        grid[guard[0]][guard[1]] = 1
    }

    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for _, guard := range guards {
        for _, dir := range dirs {
            x, y := guard[0] + dir[0], guard[1] + dir[1]
            for x >= 0 && x < m && y >= 0 && y < n && grid[x][y] != 1 && grid[x][y] != 2 {
                if grid[x][y] == 0 {
                    grid[x][y] = 3
                }
                x += dir[0]
                y += dir[1]
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