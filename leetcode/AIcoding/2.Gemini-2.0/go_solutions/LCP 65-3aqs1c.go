func optimalHumidity(target int, locations []int) int {
	n := len(locations)
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, target+1)
		for j := range dp[i] {
			dp[i][j] = 1000000000
		}
	}
	dp[0][0] = 0

	for i := 1; i <= n; i++ {
		for j := 0; j <= target; j++ {
			dp[i][j] = dp[i-1][j]
			if j >= locations[i-1] {
				dp[i][j] = min(dp[i][j], dp[i-1][j-locations[i-1]]+1)
			}
		}
	}

	if dp[n][target] == 1000000000 {
		return -1
	}
	return dp[n][target]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}