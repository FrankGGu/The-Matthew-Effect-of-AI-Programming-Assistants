func probabilityOfHeads(prob []float64, target int) float64 {
    n := len(prob)
    dp := make([]float64, target+1)
    dp[0] = 1.0

    for _, p := range prob {
        for j := target; j > 0; j-- {
            dp[j] = dp[j]*(1-p) + dp[j-1]*p
        }
        dp[0] *= (1 - p)
    }

    return dp[target]
}