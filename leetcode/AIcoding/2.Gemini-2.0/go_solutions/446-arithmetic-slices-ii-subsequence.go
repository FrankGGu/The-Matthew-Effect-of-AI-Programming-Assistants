func numberOfArithmeticSlices(nums []int) int {
	n := len(nums)
	dp := make([]map[int]int, n)
	for i := range dp {
		dp[i] = make(map[int]int)
	}
	ans := 0
	for i := 0; i < n; i++ {
		for j := 0; j < i; j++ {
			diff := nums[i] - nums[j]
			count := dp[j][diff]
			dp[i][diff] += count + 1
			ans += count
		}
	}
	return ans
}