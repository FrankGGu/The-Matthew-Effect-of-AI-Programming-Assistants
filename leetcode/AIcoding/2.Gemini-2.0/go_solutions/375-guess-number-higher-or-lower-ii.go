func getMoneyAmount(n int) int {
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
	}

	for length := 2; length <= n; length++ {
		for start := 1; start <= n-length+1; start++ {
			end := start + length - 1
			dp[start][end] = 1<<31 - 1
			for i := start; i <= end; i++ {
				cost := i
				if i > start {
					cost += dp[start][i-1]
				}
				if i < end {
					cost += dp[i+1][end]
				}
				dp[start][end] = min(dp[start][end], cost)
			}
		}
	}

	return dp[1][n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}