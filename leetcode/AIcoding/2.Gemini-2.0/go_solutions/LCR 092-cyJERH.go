func minFlipsMonoIncr(s string) int {
	n := len(s)
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, 2)
	}

	for i := 1; i <= n; i++ {
		if s[i-1] == '0' {
			dp[i][0] = dp[i-1][0]
			dp[i][1] = min(dp[i-1][0], dp[i-1][1]) + 1
		} else {
			dp[i][0] = dp[i-1][0] + 1
			dp[i][1] = min(dp[i-1][0], dp[i-1][1])
		}
	}

	return min(dp[n][0], dp[n][1])
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}