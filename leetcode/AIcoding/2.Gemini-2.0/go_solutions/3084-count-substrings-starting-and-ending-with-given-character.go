func countSubstrings(s string, char byte) int {
	count := 0
	for i := 0; i < len(s); i++ {
		for j := i; j < len(s); j++ {
			if s[i] == char && s[j] == char {
				count++
			}
		}
	}
	return count
}