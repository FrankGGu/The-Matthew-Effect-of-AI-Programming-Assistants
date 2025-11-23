func numDistinct(s string, t string) int {
	m := len(s)
	n := len(t)

	// dp[i][j] represents the number of distinct subsequences of s[0...i-1] that equal t[0...j-1]
	dp := make([][]int, m+1