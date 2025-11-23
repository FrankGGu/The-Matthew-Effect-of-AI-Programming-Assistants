func iceBreakingGame(iceBreakers []int) int {
	n := len(iceBreakers)
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = iceBreakers[i-1]
		if i >= 2 {
			dp[i] = max(dp[i], dp[i-2]+iceBreakers[i-1])
		}
		if i > 1 {
			dp[i] = max(dp[i], dp[i-1])
		}
	}
	return dp[n]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}