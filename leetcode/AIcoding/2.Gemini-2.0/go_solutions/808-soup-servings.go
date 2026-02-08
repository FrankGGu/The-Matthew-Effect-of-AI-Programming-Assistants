func soupServings(n int) float64 {
	if n > 4800 {
		return 1.0
	}
	n = (n + 24) / 25
	dp := make([][]float64, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]float64, n+1)
	}

	dp[0][0] = 0.0
	dp[0][1] = 1.0
	dp[1][0] = 0.0

	for i := 1; i <= n; i++ {
		dp[i][0] = 0.0
	}
	for j := 1; j <= n; j++ {
		dp[0][j] = 1.0
	}

	for i := 1; i <= n; i++ {
		for j := 1; j <= n; j++ {
			dp[i][j] = 0.25 * (get(dp, i-4, j) + get(dp, i-3, j-1) + get(dp, i-2, j-2) + get(dp, i-1, j-3))
		}
	}

	return dp[n][n]
}

func get(dp [][]float64, i, j int) float64 {
	if i <= 0 && j <= 0 {
		return 1.0
	} else if i <= 0 {
		return 1.0
	} else if j <= 0 {
		return 0.0
	}
	return dp[i][j]
}