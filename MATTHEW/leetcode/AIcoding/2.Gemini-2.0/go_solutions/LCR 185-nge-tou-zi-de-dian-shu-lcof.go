func probabilityOfHeads(prob []float64, target int) float64 {
	n := len(prob)
	dp := make([][]float64, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]float64, target+1)
	}

	dp[0][0] = 1.0

	for i := 1; i <= n; i++ {
		for j := 0; j <= target; j++ {
			if j == 0 {
				dp[i][j] = dp[i-1][j] * (1 - prob[i-1])
			} else {
				dp[i][j] = dp[i-1][j] * (1 - prob[i-1]) + dp[i-1][j-1] * prob[i-1]
			}
		}
	}

	return dp[n][target]
}