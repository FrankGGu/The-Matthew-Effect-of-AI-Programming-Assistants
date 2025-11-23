func minIncrementOperations(nums []int, k int) int64 {
	n := len(nums)
	dp := make([]int64, n+1)
	dp[0] = 0
	dp[1] = int64(max(0, k-nums[0]))
	if n > 1 {
		dp[2] = int64(min(dp[1]+int64(max(0, k-nums[1])), int64(max(0, k-max(nums[0], nums[1])))))
	}
	for i := 3; i <= n; i++ {
		dp[i] = min(dp[i-1]+int64(max(0, k-nums[i-1])),
			min(dp[i-2]+int64(max(0, k-max(nums[i-1], nums[i-2]))),
				dp[i-3]+int64(max(0, k-max(nums[i-1], max(nums[i-2], nums[i-3]))))))
	}
	return dp[n]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}