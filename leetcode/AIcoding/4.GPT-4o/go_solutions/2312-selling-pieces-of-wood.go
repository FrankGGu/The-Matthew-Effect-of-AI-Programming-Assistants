func woodSell(prices []int, n int) int {
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		for j := 1; j <= i; j++ {
			if j <= len(prices) {
				dp[i] = max(dp[i], dp[i-j]+prices[j-1])
			}
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