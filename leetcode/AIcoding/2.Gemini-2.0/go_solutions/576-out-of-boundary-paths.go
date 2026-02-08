func findPaths(m int, n int, maxMove int, startRow int, startColumn int) int {
    dp := make([][][]int, maxMove+1)
    for i := 0; i <= maxMove; i++ {
        dp[i] = make([][]int, m)
        for j := 0; j < m; j++ {
            dp[i][j] = make([]int, n)
        }
    }

    mod := 1000000007

    for i := 1; i <= maxMove; i++ {
        for r := 0; r < m; r++ {
            for c := 0; c < n; c++ {
                if r == 0 {
                    dp[i][r][c] = (dp[i][r][c] + 1) % mod
                }
                if r == m-1 {
                    dp[i][r][c] = (dp[i][r][c] + 1) % mod
                }
                if c == 0 {
                    dp[i][r][c] = (dp[i][r][c] + 1) % mod
                }
                if c == n-1 {
                    dp[i][r][c] = (dp[i][r][c] + 1) % mod
                }

                if r > 0 {
                    dp[i][r][c] = (dp[i][r][c] + dp[i-1][r-1][c]) % mod
                }
                if r < m-1 {
                    dp[i][r][c] = (dp[i][r][c] + dp[i-1][r+1][c]) % mod
                }
                if c > 0 {
                    dp[i][r][c] = (dp[i][r][c] + dp[i-1][r][c-1]) % mod
                }
                if c < n-1 {
                    dp[i][r][c] = (dp[i][r][c] + dp[i-1][r][c+1]) % mod
                }
            }
        }
    }

    return dp[maxMove][startRow][startColumn]
}