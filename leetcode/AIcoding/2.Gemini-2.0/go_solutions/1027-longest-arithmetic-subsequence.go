func longestArithSeqLength(nums []int) int {
	n := len(nums)
	if n <= 2 {
		return n
	}

	dp := make([]map[int]int, n)
	for i := range dp {
		dp[i] = make(map[int]int)
	}

	ans := 2
	for i := 1; i < n; i++ {
		for j := 0; j < i; j++ {
			diff := nums[i] - nums[j]
			if _, ok := dp[j][diff]; ok {
				dp[i][diff] = dp[j][diff] + 1
			} else {
				dp[i][diff] = 2
			}
			ans = max(ans, dp[i][diff])
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}