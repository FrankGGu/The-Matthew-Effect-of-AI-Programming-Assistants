func countSpecialSubsequences(nums []int) int {
	mod := int(1e9 + 7)
	dp := make([]int, 3)

	for _, num := range nums {
		if num == 0 {
			dp[0] = (2*dp[0] + 1) % mod
		} else if num == 1 {
			dp[1] = (2*dp[1] + dp[0]) % mod
		} else {
			dp[2] = (2*dp[2] + dp[1]) % mod
		}
	}

	return dp[2]
}