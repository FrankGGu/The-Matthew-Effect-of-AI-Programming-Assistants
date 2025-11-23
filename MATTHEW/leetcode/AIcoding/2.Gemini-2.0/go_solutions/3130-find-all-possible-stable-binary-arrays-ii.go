func possibleBinaryArrays(n int, k int) int {
	const MOD = 1000000007
	dp := make([][][]int, n+1)
	for i := range dp {
		dp[i] = make([][]int, k+1)
		for j := range dp[i] {
			dp[i][j] = make([]int, 2)
		}
	}

	dp[0][0][0] = 1
	for i := 1; i <= n; i++ {
		for j := 0; j <= k; j++ {
			// Place 0
			dp[i][j][0] = (dp[i][j][0] + dp[i-1][j][0]) % MOD
			dp[i][j][0] = (dp[i][j][0] + dp[i-1][j][1]) % MOD

			// Place 1
			if j > 0 {
				dp[i][j][1] = (dp[i][j][1] + dp[i-1][j-1][0]) % MOD
			}
			dp[i][j][1] = (dp[i][j][1] + dp[i-1][j][1]) % MOD
		}
	}

	return (dp[n][k][0] + dp[n][k][1]) % MOD
}