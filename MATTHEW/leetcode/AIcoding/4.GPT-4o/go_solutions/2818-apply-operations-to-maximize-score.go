func maximumScore(nums []int, multipliers []int) int {
	n := len(nums)
	m := len(multipliers)
	dp := make([]int, m+1)

	for i := m - 1; i >= 0; i-- {
		dpNew := make([]int, m+1)
		for j := 0; j <= i; j++ {
			left := dp[j] + nums[j]*multipliers[i]
			right := dp[j+1] + nums[n-1-(i-j)]*multipliers[i]
			dpNew[j] = max(left, right)
		}
		dp = dpNew
	}
	return dp[0]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}