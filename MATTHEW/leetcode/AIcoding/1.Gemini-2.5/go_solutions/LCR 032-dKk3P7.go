func isAnagram(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}

	counts := make([]int, 26) // For lowercase English letters 'a' through 'z'

	for i := 0; i < len(s); i++ {
		counts[s[i]-'a']++
		counts[t[i]-'a']--
	}

	for _, count := range counts {
		if count != 0 {
			return false
		}
	}

	return true
}