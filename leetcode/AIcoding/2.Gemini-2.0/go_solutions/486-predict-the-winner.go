func PredictTheWinner(nums []int) bool {
	n := len(nums)
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := 0; i < n; i++ {
		dp[i][i] = nums[i]
	}

	for len := 2; len <= n; len++ {
		for i := 0; i <= n-len; i++ {
			j := i + len - 1
			dp[i][j] = max(nums[i]-dp[i+1][j], nums[j]-dp[i][j-1])
		}
	}

	return dp[0][n-1] >= 0
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}