func sandArea(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

    dfs := func(x, y int) {
        if x < 0 || x >= m || y < 0 || y >= n || grid[x][y] == 0 {
            return
        }
        grid[x][y] = 0
        for _, dir := range directions {
            dfs(x+dir[0], y+dir[1])
        }
    }

    count := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                count++
                dfs(i, j)
            }
        }
    }
    return count
}