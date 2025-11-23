func lengthOfLongestSubsequence(nums []int, target int) int {
	n := len(nums)
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, target+1)
		for j := range dp[i] {
			dp[i][j] = -1
		}
	}

	for i := 0; i <= n; i++ {
		dp[i][0] = 0
	}

	for i := 1; i <= n; i++ {
		for j := 1; j <= target; j++ {
			if nums[i-1] <= j {
				dp[i][j] = max(dp[i-1][j], dp[i-1][j-nums[i-1]]+1)
			} else {
				dp[i][j] = dp[i-1][j]
			}
		}
	}

	return dp[n][target]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}