func longestUnequalAdjacentGroupsSubsequence(words []string, groups []int) int {
	n := len(words)
	dp := make([]int, n)
	for i := 0; i < n; i++ {
		dp[i] = 1
	}

	for i := 1; i < n; i++ {
		for j := 0; j < i; j++ {
			if groups[i] != groups[j] && isSubsequence(words[j], words[i]) {
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

func isSubsequence(s string, t string) bool {
	i, j := 0, 0
	for i < len(s) && j < len(t) {
		if s[i] == t[j] {
			i++
		}
		j++
	}
	return i == len(s)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}