func sellingWood(m int, n int, prices [][]int) int64 {
    dp := make([][]int64, m+1)
    for i := range dp {
        dp[i] = make([]int64, n+1)
    }

    priceMap := make(map[[2]int]int64)
    for _, p := range prices {
        priceMap[[2]int{p[0], p[1]}] = int64(p[2])
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            dp[i][j] = priceMap[[2]int{i, j}]
            for k := 1; k < i; k++ {
                if dp[k][j] + dp[i-k][j] > dp[i][j] {
                    dp[i][j] = dp[k][j] + dp[i-k][j]
                }
            }
            for k := 1; k < j; k++ {
                if dp[i][k] + dp[i][j-k] > dp[i][j] {
                    dp[i][j] = dp[i][k] + dp[i][j-k]
                }
            }
        }
    }

    return dp[m][n]
}