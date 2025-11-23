func maxProduct(nums []int, k int) int {
	n := len(nums)
	mod := int(1e9 + 7)
	dp := make([][]map[int]int, n+1)
	for i := range dp {
		dp[i] = make([]map[int]int, 2)
		for j := range dp[i] {
			dp[i][j] = make(map[int]int)
		}
	}

	dp[0][0][0] = 1
	dp[0][1][0] = 1

	for i := 1; i <= n; i++ {
		for j := 0; j < 2; j++ {
			for sum, product := range dp[i-1][j] {
				dp[i][j][sum] = (dp[i][j][sum] + product) % mod

				newSum := sum + nums[i-1]
				sign := 1
				if j == 1 {
					sign = -1
					newSum = sum - nums[i-1]
				}
				dp[i][1-j][newSum] = (dp[i][1-j][newSum] + product*nums[i-1]) % mod
			}
		}
	}

	return dp[n][0][k]
}