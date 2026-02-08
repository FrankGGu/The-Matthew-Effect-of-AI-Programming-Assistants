func canCut(grid [][]int) bool {
    m, n := len(grid), len(grid[0])

    var dfs func(x, y int, val int) bool
    dfs = func(x, y int, val int) bool {
        if x < 0 || x >= m || y < 0 || y >= n || grid[x][y] != val {
            return false
        }
        grid[x][y] = -1
        return dfs(x-1, y, val) || dfs(x+1, y, val) || dfs(x, y-1, val) || dfs(x, y+1, val)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] != -1 {
                count := 0
                val := grid[i][j]
                dfs(i, j, val)
                for x := 0; x < m; x++ {
                    for y := 0; y < n; y++ {
                        if grid[x][y] == val {
                            count++
                        }
                    }
                }
                if count%2 != 0 {
                    return false
                }
            }
        }
    }

    return true
}