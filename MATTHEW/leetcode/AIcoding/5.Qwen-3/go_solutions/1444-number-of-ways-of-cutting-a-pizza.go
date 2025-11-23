package main

func ways(grid [][]string) int {
    mod := 1000000007
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    memo := make([][]int, m)
    for i := range memo {
        memo[i] = make([]int, n)
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == "A" {
                dp[i][j] = 1
            }
        }
    }
    for i := m - 2; i >= 0; i-- {
        for j := n - 2; j >= 0; j-- {
            dp[i][j] = (dp[i+1][j] + dp[i][j+1] - dp[i+1][j+1]) % mod
            if grid[i][j] == "A" {
                dp[i][j]++
            }
        }
    }
    var dfs func(int, int) int
    dfs = func(i, j int) int {
        if memo[i][j] != 0 {
            return memo[i][j]
        }
        res := 0
        for x := i + 1; x < m; x++ {
            if dp[i][j] > dp[x][j] && dp[x][j] > 0 {
                res = (res + dfs(x, j)) % mod
            }
        }
        for y := j + 1; y < n; y++ {
            if dp[i][j] > dp[i][y] && dp[i][y] > 0 {
                res = (res + dfs(i, y)) % mod
            }
        }
        memo[i][j] = res
        return res
    }
    return dfs(0, 0)
}