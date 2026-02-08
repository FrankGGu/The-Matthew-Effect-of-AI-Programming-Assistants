func truncateSentence(s string, k int) string {
	count := 0
	for i := 0; i < len(s); i++ {
		if s[i] == ' ' {
			count++
			if count == k {
				return s[:i]
			}
		}
	}
	return s
}