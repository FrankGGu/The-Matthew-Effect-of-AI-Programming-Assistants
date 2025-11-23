func isValidParenthesesStringPath(grid [][]byte) bool {
    m, n := len(grid), len(grid[0])
    if (m+n-1)%2 != 0 {
        return false
    }
    maxK := (m + n - 1) / 2
    dp := make([][][]bool, m)
    for i := range dp {
        dp[i] = make([][]bool, n)
        for j := range dp[i] {
            dp[i][j] = make([]bool, maxK+1)
        }
    }
    if grid[0][0] == '(' {
        dp[0][0][1] = true
    } else {
        return false
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if i == 0 && j == 0 {
                continue
            }
            for k := 0; k <= maxK; k++ {
                if i > 0 {
                    if grid[i][j] == '(' {
                        if k > 0 && dp[i-1][j][k-1] {
                            dp[i][j][k] = true
                        }
                    } else {
                        if k+1 <= maxK && dp[i-1][j][k+1] {
                            dp[i][j][k] = true
                        }
                    }
                }
                if j > 0 {
                    if grid[i][j] == '(' {
                        if k > 0 && dp[i][j-1][k-1] {
                            dp[i][j][k] = true
                        }
                    } else {
                        if k+1 <= maxK && dp[i][j-1][k+1] {
                            dp[i][j][k] = true
                        }
                    }
                }
            }
        }
    }
    return dp[m-1][n-1][0]
}