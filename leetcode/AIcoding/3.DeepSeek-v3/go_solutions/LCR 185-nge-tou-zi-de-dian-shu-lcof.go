func dicesProbability(n int) []float64 {
    dp := make([][]float64, n+1)
    for i := range dp {
        dp[i] = make([]float64, 6*n+1)
    }

    for i := 1; i <= 6; i++ {
        dp[1][i] = 1.0 / 6.0
    }

    for i := 2; i <= n; i++ {
        for j := i; j <= 6*i; j++ {
            for k := 1; k <= 6; k++ {
                if j-k >= 0 {
                    dp[i][j] += dp[i-1][j-k] / 6.0
                }
            }
        }
    }

    res := make([]float64, 0)
    for j := n; j <= 6*n; j++ {
        res = append(res, dp[n][j])
    }
    return res
}