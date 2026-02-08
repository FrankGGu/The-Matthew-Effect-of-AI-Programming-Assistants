func isScramble(s1 string, s2 string) bool {
	if len(s1) != len(s2) {
		return false
	}
	if s1 == s2 {
		return true
	}
	n := len(s1)
	count := make([]int, 26)
	for i := 0; i < n; i++ {
		count[s1[i]-'a']++
		count[s2[i]-'a']--
	}
	for i := 0; i < 26; i++ {
		if count[i] != 0 {
			return false
		}
	}
	for i := 1; i < n; i++ {
		if isScramble(s1[:i], s2[:i]) && isScramble(s1[i:], s2[i:]) {
			return true
		}
		if isScramble(s1[:i], s2[n-i:]) && isScramble(s1[i:], s2[:n-i]) {
			return true
		}
	}
	return false
}