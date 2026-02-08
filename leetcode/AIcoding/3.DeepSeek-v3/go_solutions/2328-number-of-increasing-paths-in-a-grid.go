func countPaths(grid [][]int) int {
    mod := int(1e9 + 7)
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if dp[i][j] != 0 {
            return dp[i][j]
        }
        res := 1
        for _, dir := range directions {
            x, y := i + dir[0], j + dir[1]
            if x >= 0 && x < m && y >= 0 && y < n && grid[x][y] > grid[i][j] {
                res = (res + dfs(x, y)) % mod
            }
        }
        dp[i][j] = res
        return res
    }

    total := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            total = (total + dfs(i, j)) % mod
        }
    }
    return total
}