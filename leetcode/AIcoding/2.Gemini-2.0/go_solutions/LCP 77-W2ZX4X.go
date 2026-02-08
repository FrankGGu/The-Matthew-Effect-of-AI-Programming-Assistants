func runeReserve(runes []int) int {
	n := len(runes)
	dp := make([]int, n)
	dp[0] = 1
	for i := 1; i < n; i++ {
		dp[i] = 1
		for j := 0; j < i; j++ {
			if runes[i] > runes[j] {
				dp[i] = max(dp[i], dp[j]+1)
			}
		}
	}
	ans := 0
	for i := 0; i < n; i++ {
		ans = max(ans, dp[i])
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}