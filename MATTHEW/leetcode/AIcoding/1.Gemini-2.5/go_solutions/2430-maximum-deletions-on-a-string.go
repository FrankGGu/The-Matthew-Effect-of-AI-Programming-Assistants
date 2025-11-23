func maxDeletions(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	// lcp[i][j] stores the length of the longest common prefix between s[i:] and s[j:]
	lcp := make([][]int