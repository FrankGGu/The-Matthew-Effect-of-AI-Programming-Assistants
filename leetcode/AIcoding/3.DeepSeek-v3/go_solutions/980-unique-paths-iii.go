func uniquePathsIII(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    startX, startY, empty := 0, 0, 1
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                startX, startY = i, j
            } else if grid[i][j] == 0 {
                empty++
            }
        }
    }
    res := 0
    var dfs func(x, y, count int)
    dfs = func(x, y, count int) {
        if x < 0 || x >= m || y < 0 || y >= n || grid[x][y] == -1 {
            return
        }
        if grid[x][y] == 2 {
            if count == empty {
                res++
            }
            return
        }
        grid[x][y] = -1
        dfs(x+1, y, count+1)
        dfs(x-1, y, count+1)
        dfs(x, y+1, count+1)
        dfs(x, y-1, count+1)
        grid[x][y] = 0
    }
    dfs(startX, startY, 0)
    return res
}