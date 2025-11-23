func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func maximumSum(nums []int) int64 {
	n := len(nums)
	dp := make([][]int64, n)
	for i := range dp {
		dp[i] = make([]int64, 3)
	}

	dp[0][0] = int64(nums[0])
	dp[0][1] = int64(nums[0])
	dp[0][2] = int64(nums[0])

	ans := int64(nums[0])

	for i := 1; i < n; i++ {
		dp[i][0] = int64(nums[i])
		dp[i][1] = dp[i-1][0] + int64(nums[i])
		dp[i][2] = dp[i-1][1] + int64(nums[i])

		dp[i][1] = max(dp[i][1], int64(nums[i]))
		dp[i][2] = max(dp[i][2], int64(nums[i]))

		dp[i][0] = max(dp[i][0], dp[i-1][0])
		dp[i][1] = max(dp[i][1], dp[i-1][1])
		dp[i][2] = max(dp[i][2], dp[i-1][2])

		ans = max(ans, dp[i][0])
		ans = max(ans, dp[i][1])
		ans = max(ans, dp[i][2])
	}

	return ans
}