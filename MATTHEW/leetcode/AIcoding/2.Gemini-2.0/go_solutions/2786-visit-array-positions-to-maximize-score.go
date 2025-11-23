func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxScore(nums []int, x int) int64 {
	n := len(nums)
	dp := make([][2]int, n)

	if nums[0]%2 == 0 {
		dp[0][0] = nums[0]
		dp[0][1] = -1000000000
	} else {
		dp[0][1] = nums[0]
		dp[0][0] = -1000000000
	}

	for i := 1; i < n; i++ {
		if nums[i]%2 == 0 {
			dp[i][0] = max(dp[i-1][0]+nums[i], dp[i-1][1]+nums[i]-x)
			dp[i][1] = dp[i-1][1]
		} else {
			dp[i][1] = max(dp[i-1][1]+nums[i], dp[i-1][0]+nums[i]-x)
			dp[i][0] = dp[i-1][0]
		}
	}

	ans := max(dp[n-1][0], dp[n-1][1])
	return int64(ans)
}