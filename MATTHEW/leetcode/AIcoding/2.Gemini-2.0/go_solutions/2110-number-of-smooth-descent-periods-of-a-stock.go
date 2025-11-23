func getDescentPeriods(prices []int) int64 {
	n := len(prices)
	dp := make([]int64, n)
	dp[0] = 1
	ans := int64(1)
	for i := 1; i < n; i++ {
		if prices[i] == prices[i-1]-1 {
			dp[i] = dp[i-1] + 1
		} else {
			dp[i] = 1
		}
		ans += dp[i]
	}
	return ans
}