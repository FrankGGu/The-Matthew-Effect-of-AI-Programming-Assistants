package main

func countPaths(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    mod := 1000000007

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if dp[i][j] != 0 {
            return dp[i][j]
        }
        res := 1
        for _, d := range directions {
            ni, nj := i+d[0], j+d[1]
            if ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] > grid[i][j] {
                res += dfs(ni, nj)
                res %= mod
            }
        }
        dp[i][j] = res
        return res
    }

    result := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            result += dfs(i, j)
            result %= mod
        }
    }
    return result
}