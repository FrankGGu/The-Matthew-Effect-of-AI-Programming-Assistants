func getLongestSubsequence(words []string, groups []int) []string {
	n := len(words)
	if n == 0 {
		return []string{}
	}

	dp := make([]int, n)
	prev := make([]int,