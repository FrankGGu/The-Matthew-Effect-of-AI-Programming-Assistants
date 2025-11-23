func countPaths(grid [][]int) int {
    mod := int(1e9 + 7)
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    directions := []struct{ x, y int }{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    var dfs func(x, y int) int
    dfs = func(x, y int) int {
        if dp[x][y] != 0 {
            return dp[x][y]
        }
        dp[x][y] = 1
        for _, dir := range directions {
            nx, ny := x+dir.x, y+dir.y
            if nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] > grid[x][y] {
                dp[x][y] = (dp[x][y] + dfs(nx, ny)) % mod
            }
        }
        return dp[x][y]
    }

    result := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            result = (result + dfs(i, j)) % mod
        }
    }
    return result
}