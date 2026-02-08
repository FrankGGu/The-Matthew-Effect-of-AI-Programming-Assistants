func expressiveWords(s string, words []string) int {
	count := 0
	for _, word := range words {
		if isStretchy(s, word) {
			count++
		}
	}
	return count
}

func isStretchy(s string, word string) bool {
	i, j := 0, 0
	for i < len(s) && j < len(word) {
		if s[i] != word[j] {
			return false
		}
		char := s[i]
		sCount := 0
		for i < len(s) && s[i] == char {
			sCount++
			i++
		}
		wCount := 0
		for j < len(word) && word[j] == char {
			wCount++
			j++
		}
		if sCount < wCount {
			return false
		}
		if sCount != wCount && sCount < 3 {
			return false
		}
	}
	return i == len(s) && j == len(word)
}