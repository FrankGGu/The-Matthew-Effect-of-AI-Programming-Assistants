func maximumSumWithK(nums []int, k int) int {
	n := len(nums)
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = dp[i-1]
		for j := 1; j <= k && i-j >= 0; j++ {
			sum := 0
			for l := i - j; l < i; l++ {
				sum += nums[l]
			}
			dp[i] = max(dp[i], dp[i-j] + sum)
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