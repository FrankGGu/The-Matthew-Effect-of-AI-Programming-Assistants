package main

func minSquare(n int, m int) int {
    if n == m {
        return 1
    }
    if n > m {
        n, m = m, n
    }
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }
    for i := 0; i <= n; i++ {
        for j := 0; j <= m; j++ {
            if i == 0 || j == 0 {
                dp[i][j] = 0
            } else if i == j {
                dp[i][j] = 1
            } else {
                dp[i][j] = 1e9
                for k := 1; k < i; k++ {
                    dp[i][j] = min(dp[i][j], dp[k][j]+dp[i-k][j])
                }
                for k := 1; k < j; k++ {
                    dp[i][j] = min(dp[i][j], dp[i][k]+dp[i][j-k])
                }
                for k := 1; k < i; k++ {
                    for l := 1; l < j; l++ {
                        dp[i][j] = min(dp[i][j], dp[k][l]+dp[i-k][l]+dp[k][j-l]+dp[i-k][j-l])
                    }
                }
            }
        }
    }
    return dp[n][m]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}