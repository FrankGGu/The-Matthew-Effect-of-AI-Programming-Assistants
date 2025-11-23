func minCost(n int, cost []int) int {
	if n <= 1 {
		return 0
	}
	dp := make([]int, n)
	dp[0] = 0
	dp[1] = cost[0]

	for i := 2; i < n; i++ {
		dp[i] = min(dp[i-1]+cost[i-1], dp[i-2]+cost[i-2]*2)
	}

	return dp[n-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}