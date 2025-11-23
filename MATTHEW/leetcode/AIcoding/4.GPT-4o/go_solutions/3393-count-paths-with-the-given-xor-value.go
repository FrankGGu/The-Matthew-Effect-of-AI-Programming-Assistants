func countPaths(grid [][]int, x int) int {
    m, n := len(grid), len(grid[0])
    mod := int(1e9 + 7)
    dp := make([][][]int, m)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, 1024)
        }
    }
    dp[0][0][grid[0][0]] = 1

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            for k := 0; k < 1024; k++ {
                if dp[i][j][k] > 0 {
                    if i+1 < m {
                        dp[i+1][j][k^grid[i+1][j]] = (dp[i+1][j][k^grid[i+1][j]] + dp[i][j][k]) % mod
                    }
                    if j+1 < n {
                        dp[i][j+1][k^grid[i][j+1]] = (dp[i][j+1][k^grid[i][j+1]] + dp[i][j][k]) % mod
                    }
                }
            }
        }
    }

    return dp[m-1][n-1][x]
}