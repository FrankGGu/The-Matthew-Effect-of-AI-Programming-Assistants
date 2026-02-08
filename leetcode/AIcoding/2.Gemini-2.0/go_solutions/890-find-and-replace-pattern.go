func findAndReplacePattern(words []string, pattern string) []string {
	res := []string{}
	for _, word := range words {
		if match(word, pattern) {
			res = append(res, word)
		}
	}
	return res
}

func match(word string, pattern string) bool {
	if len(word) != len(pattern) {
		return false
	}
	m1 := make(map[byte]byte)
	m2 := make(map[byte]byte)
	for i := 0; i < len(word); i++ {
		c1 := word[i]
		c2 := pattern[i]
		if _, ok := m1[c1]; !ok {
			m1[c1] = c2
		}
		if _, ok := m2[c2]; !ok {
			m2[c2] = c1
		}
		if m1[c1] != c2 || m2[c2] != c1 {
			return false
		}
	}
	return true
}