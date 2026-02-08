func rob(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}
	if n == 1 {
		return nums[0]
	}
	if n == 2 {
		return max(nums[0], nums[1])
	}

	return max(robRange(nums, 0, n-2), robRange(nums, 1, n-1))
}

func robRange(nums []int, start int, end int) int {
	n := end - start + 1
	if n == 0 {
		return 0
	}
	if n == 1 {
		return nums[start]
	}

	dp := make([]int, n)
	dp[0] = nums[start]
	dp[1] = max(nums[start], nums[start+1])

	for i := 2; i < n; i++ {
		dp[i] = max(dp[i-1], dp[i-2]+nums[start+i])
	}

	return dp[n-1]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}