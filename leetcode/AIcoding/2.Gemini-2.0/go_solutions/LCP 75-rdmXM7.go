func teleport(magics []int) int {
	n := len(magics)
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = dp[i-1] + 1
		if magics[i-1] > 0 && i+magics[i-1] <= n {
			dp[i+magics[i-1]] = min(dp[i+magics[i-1]], dp[i-1]+1)
		}
	}
	return dp[n]
}

func min(a, b int) int {
	if a == 0 {
		return b
	}
	if b == 0 {
		return a
	}
	if a < b {
		return a
	}
	return b
}