func longestArithmeticSubsequence(nums []int) int {
	n := len(nums)
	if n <= 2 {
		return n
	}

	dp := make([]map[int]int, n)
	maxLen := 1

	for i := 0; i < n; i++ {
		dp[i] = make(map[int]int)
		for j := 0; j < i; j++ {
			diff := nums[i] - nums[j]

			prevLen := 1
			if val, ok := dp[j][diff]; ok {
				prevLen = val
			}

			currentLen := prevLen + 1

			dp[i][diff] = max(dp[i][diff], currentLen)

			maxLen = max(maxLen, currentLen)
		}
	}

	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}