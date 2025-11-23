func wordPattern(pattern string, s string) bool {
	words := strings.Fields(s)

	if len(pattern) != len(words) {
		return false
	}

	charToWord := make(map[rune]string)
	wordToChar := make