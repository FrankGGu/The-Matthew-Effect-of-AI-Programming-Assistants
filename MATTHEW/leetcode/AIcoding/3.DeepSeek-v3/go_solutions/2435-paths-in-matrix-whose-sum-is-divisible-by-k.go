func numberOfPaths(grid [][]int, k int) int {
    mod := int(1e9 + 7)
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
            if i == 0 && j == 0 {
                continue
            }
            for s := 0; s < k; s++ {
                sum := (s - grid[i][j]%k + k) % k
                if i > 0 {
                    dp[i][j][s] = (dp[i][j][s] + dp[i-1][j][sum]) % mod
                }
                if j > 0 {
                    dp[i][j][s] = (dp[i][j][s] + dp[i][j-1][sum]) % mod
                }
            }
        }
    }
    return dp[m-1][n-1][0]
}