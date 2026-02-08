func isAlmostEqual(s1, s2 string) bool {
	diffCount := 0
	for i := 0; i < len(s1); i++ {
		if s1[i] != s2[i] {
			diffCount++
		}
	}
	return diffCount <= 1
}

func findFirstOccurrence(s string, sub string) int {
	n := len(s)
	m := len(sub)

	for i := 0; i <= n-m; i++ {
		if isAlmostEqual(s[i:i+m], sub) {
			return i
		}
	}

	return -1
}