func waysToCutPizza(pizza []string, k int) int {
    mod := int(1e9 + 7)
    m, n := len(pizza), len(pizza[0])
    prefix := make([][]int, m+1)
    for i := range prefix {
        prefix[i] = make([]int, n+1)
    }
    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            prefix[i][j] = prefix[i+1][j] + prefix[i][j+1] - prefix[i+1][j+1] + int(pizza[i][j] == 'A')
        }
    }

    dp := make([][][]int, k)
    for i := range dp {
        dp[i] = make([][]int, m)
        for j := range dp[i] {
            dp[i][j] = make([]int, n)
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if prefix[i][j] > 0 {
                dp[0][i][j] = 1
            }
        }
    }

    for cut := 1; cut < k; cut++ {
        for i := 0; i < m; i++ {
            for j := 0; j < n; j++ {
                for x := i + 1; x < m; x++ {
                    if prefix[i][j]-prefix[x][j] > 0 {
                        dp[cut][i][j] = (dp[cut][i][j] + dp[cut-1][x][j]) % mod
                    }
                }
                for y := j + 1; y < n; y++ {
                    if prefix[i][j]-prefix[i][y] > 0 {
                        dp[cut][i][j] = (dp[cut][i][j] + dp[cut-1][i][y]) % mod
                    }
                }
            }
        }
    }

    return dp[k-1][0][0]
}