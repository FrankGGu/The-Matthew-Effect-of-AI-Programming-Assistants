func ways(pizza []string, k int) int {
    const mod = 1e9 + 7
    m, n := len(pizza), len(pizza[0])
    apple := make([][]int, m+1)
    for i := range apple {
        apple[i] = make([]int, n+1)
    }
    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            apple[i][j] = apple[i+1][j] + apple[i][j+1] - apple[i+1][j+1]
            if pizza[i][j] == 'A' {
                apple[i][j]++
            }
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
            if apple[i][j] > 0 {
                dp[0][i][j] = 1
            }
        }
    }
    for l := 1; l < k; l++ {
        for i := 0; i < m; i++ {
            for j := 0; j < n; j++ {
                for x := i + 1; x < m; x++ {
                    if apple[i][j] - apple[x][j] > 0 {
                        dp[l][i][j] = (dp[l][i][j] + dp[l-1][x][j]) % mod
                    }
                }
                for y := j + 1; y < n; y++ {
                    if apple[i][j] - apple[i][y] > 0 {
                        dp[l][i][j] = (dp[l][i][j] + dp[l-1][i][y]) % mod
                    }
                }
            }
        }
    }
    return dp[k-1][0][0]
}