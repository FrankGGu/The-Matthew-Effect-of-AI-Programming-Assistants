func numWays(steps int, arrLen int) int {
	mod := 1000000007
	maxPos := min(steps/2, arrLen-1)
	dp := make([][]int, steps+1)
	for i := range dp {
		dp[i] = make([]int, maxPos+1)
	}
	dp[0][0] = 1

	for i := 1; i <= steps; i++ {
		for j := 0; j <= maxPos; j++ {
			dp[i][j] = dp[i-1][j]
			if j > 0 {
				dp[i][j] = (dp[i][j] + dp[i-1][j-1]) % mod
			}
			if j < maxPos {
				dp[i][j] = (dp[i][j] + dp[i-1][j+1]) % mod
			}
		}
	}

	return dp[steps][0]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}