func minValidStrings(target string, words []string) int {
	n := len(target)
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = i
		for _, word := range words {
			m := len(word)
			if i >= m && target[i-m:i] == word {
				dp[i] = min(dp[i], dp[i-m])
			}
		}
	}
	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}