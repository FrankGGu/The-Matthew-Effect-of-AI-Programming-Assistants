package main

func sellingWood(m int, n int, prices [][]int) int64 {
    dp := make([][]int64, m+1)
    for i := range dp {
        dp[i] = make([]int64, n+1)
    }

    for _, price := range prices {
        r, c, p := price[0], price[1], price[2]
        if r <= m && c <= n {
            dp[r][c] = max(dp[r][c], int64(p))
        }
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            // Consider all possible horizontal cuts
            for k := 1; k < i; k++ {
                dp[i][j] = max(dp[i][j], dp[k][j]+dp[i-k][j])
            }
            // Consider all possible vertical cuts
            for k := 1; k < j; k++ {
                dp[i][j] = max(dp[i][j], dp[i][k]+dp[i][j-k])
            }
        }
    }

    return dp[m][n]
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}