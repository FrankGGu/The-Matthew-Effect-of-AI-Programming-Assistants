func maxCoins(nums []int) int {
	n := len(nums)

	newNums := make([]int, n+2)
	newNums[0] = 1
	newNums[n+1] = 1
	for i := 0; i < n; i++ {
		newNums[i+1] = nums[i]
	}

	dp := make([][]int, n+2)
	for i := range dp {
		dp[i] = make([]int, n+2)
	}

	for length := 1; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length + 1

			for k := i + 1; k < j; k++ {
				coins := newNums[i] * newNums[k] * newNums[j]

				currentMax := dp[i][k] + dp[k][j] + coins
				if currentMax > dp[i][j] {
					dp[i][j] = currentMax
				}
			}
		}
	}

	return dp[0][n+1]
}