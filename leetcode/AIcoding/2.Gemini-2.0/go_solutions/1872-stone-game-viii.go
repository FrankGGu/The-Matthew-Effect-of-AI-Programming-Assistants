func stoneGameVIII(stones []int) int {
	n := len(stones)
	sum := make([]int, n+1)
	for i := 0; i < n; i++ {
		sum[i+1] = sum[i] + stones[i]
	}

	dp := make([]int, n)
	dp[n-1] = sum[n]
	for i := n - 2; i >= 1; i-- {
		dp[i] = max(dp[i+1], sum[i+1] - dp[i+1])
	}

	return dp[1]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}