func countSubstrings(s string, k int) int {
	n := len(s)
	count := 0

	// Pre-calculate vowel bit masks for quick lookup
	// 'a': 1 (1<<0)
	// 'e': 2 (1<<1)
	// 'i':