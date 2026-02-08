func deleteString(s string) int {
	n := len(s)
	dp := make([]int, n)
	for i := n - 1; i >= 0; i-- {
		dp[i] = 1
		for j := i + 1; j <= n/2+i && j < n; j++ {
			if s[i:j] == s[j:2*j-i] {
				dp[i] = max(dp[i], dp[j]+1)
			}
		}
	}
	return dp[0]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}