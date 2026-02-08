func numberOfPaths(grid [][]int, k int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][][]int, m)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, k)
        }
    }
    dp[0][0][grid[0][0]%k] = 1
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            for l := 0; l < k; l++ {
                if i > 0 {
                    dp[i][j][(l+grid[i][j])%k] = (dp[i][j][(l+grid[i][j])%k] + dp[i-1][j][l]) % 1000000007
                }
                if j > 0 {
                    dp[i][j][(l+grid[i][j])%k] = (dp[i][j][(l+grid[i][j])%k] + dp[i][j-1][l]) % 1000000007
                }
            }
        }
    }
    return dp[m-1][n-1][0]
}