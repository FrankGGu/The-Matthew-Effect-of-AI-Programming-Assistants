func printVertically(s string) []string {
	words := strings.Split(s, " ")
	maxLen := 0
	for _, word := range words {
		if len(word) > maxLen {
			maxLen = len(word)
		}
	}

	result := make([]string, maxLen)
	for i := 0; i < maxLen; i++ {
		result[i] = ""
	}

	for i := 0; i < maxLen; i++ {
		for _, word := range words {
			if i < len(word) {
				result[i] += string(word[i])
			} else {
				result[i] += " "
			}
		}

		result[i] = strings.TrimRight(result[i], " ")
	}

	return result
}