func predictTheWinner(nums []int) bool {
	n := len(nums)
	if n == 0 {
		return true
	}
	if n == 1 {
		return true
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := 0; i < n; i++ {
		dp[i][i] = nums[i]
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			choice1 := nums[i] - dp[i+1][j]
			choice2 := nums[j] - dp[i][j-1]
			dp[i][j] = max(choice1, choice2)
		}
	}

	return dp[0][n-1] >= 0
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}