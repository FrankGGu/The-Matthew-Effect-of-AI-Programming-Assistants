func maxSumAfterPartitioning(arr []int, k int) int {
	n := len(arr)
	dp := make([]int, n+1)

	for i := 1; i <= n; i++ {
		maxVal := 0
		for j := 1; j <= k && i-j >= 0; j++ {
			maxVal = max(maxVal, arr[i-j])
			dp[i] = max(dp[i], dp[i-j]+maxVal*j)
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