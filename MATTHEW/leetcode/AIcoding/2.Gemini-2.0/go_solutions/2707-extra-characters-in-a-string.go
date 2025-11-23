import "math"

func minExtraChar(s string, dictionary []string) int {
	n := len(s)
	dp := make([]int, n+1)

	for i := 1; i <= n; i++ {
		dp[i] = dp[i-1] + 1
		for _, word := range dictionary {
			if i >= len(word) && s[i-len(word):i] == word {
				dp[i] = min(dp[i], dp[i-len(word)])
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