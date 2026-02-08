func checkRecord(n int) int {
	const MOD = 1000000007
	dp := make([][][]int, n+1)
	for i := range dp {
		dp[i] = make([][]int, 2)
		for j := range dp[i] {
			dp[i][j] = make([]int, 3)
		}
	}

	dp[0][0][0] = 1

	for i := 1; i <= n; i++ {
		for j := 0; j <= 1; j++ {
			for k := 0; k <= 2; k++ {
				// Present
				dp[i][j][0] = (dp[i][j][0] + dp[i-1][j][k]) % MOD

				// Absent
				if j == 0 {
					dp[i][1][0] = (dp[i][1][0] + dp[i-1][j][k]) % MOD
				}

				// Late
				if k < 2 {
					dp[i][j][k+1] = (dp[i][j][k+1] + dp[i-1][j][k]) % MOD
				}
			}
		}
	}

	ans := 0
	for j := 0; j <= 1; j++ {
		for k := 0; k <= 2; k++ {
			ans = (ans + dp[n][j][k]) % MOD
		}
	}

	return ans
}