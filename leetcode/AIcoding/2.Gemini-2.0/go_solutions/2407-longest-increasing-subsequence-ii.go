func lengthOfLIS(nums []int, k int) int {
	n := len(nums)
	dp := make([]int, 100001)
	for i := 0; i <= 100000; i++ {
		dp[i] = 0
	}

	maxVal := 0
	for i := 0; i < n; i++ {
		left := max(1, nums[i]-k)
		right := nums[i] - 1
		maxLen := 0
		for j := left; j <= right; j++ {
			maxLen = max(maxLen, dp[j])
		}

		dp[nums[i]] = max(dp[nums[i]], maxLen+1)
		maxVal = max(maxVal, dp[nums[i]])
	}

	return maxVal
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}