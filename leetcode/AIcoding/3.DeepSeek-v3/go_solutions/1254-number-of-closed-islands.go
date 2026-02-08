func closedIsland(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    count := 0

    var dfs func(int, int) bool
    dfs = func(i, j int) bool {
        if i < 0 || i >= m || j < 0 || j >= n {
            return false
        }
        if grid[i][j] == 1 {
            return true
        }
        grid[i][j] = 1
        up := dfs(i-1, j)
        down := dfs(i+1, j)
        left := dfs(i, j-1)
        right := dfs(i, j+1)
        return up && down && left && right
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                if dfs(i, j) {
                    count++
                }
            }
        }
    }
    return count
}