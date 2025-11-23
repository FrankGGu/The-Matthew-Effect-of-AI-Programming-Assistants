func maxProfit(p []int, f int) int {
	n := len(p)
	dp := make([]int, f+1)
	for i := 1; i <= n; i++ {
		for j := f; j >= p[i-1]; j-- {
			dp[j] = max(dp[j], dp[j-p[i-1]]+p[i-1])
		}
	}
	return dp[f]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}