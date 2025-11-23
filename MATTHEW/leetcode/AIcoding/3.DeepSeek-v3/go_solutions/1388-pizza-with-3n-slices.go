func maxSizeSlices(slices []int) int {
	n := len(slices)
	k := n / 3
	return max(helper(slices[:n-1], k), helper(slices[1:], k))
}

func helper(slices []int, k int) int {
	m := len(slices)
	dp := make([][]int, m+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}
	for i := 1; i <= m; i++ {
		for j := 1; j <= k; j++ {
			if i == 1 {
				dp[i][j] = slices[i-1]
			} else {
				dp[i][j] = max(dp[i-1][j], dp[i-2][j-1]+slices[i-1])
			}
		}
	}
	return dp[m][k]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}