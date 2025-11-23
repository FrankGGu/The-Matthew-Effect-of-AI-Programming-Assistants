func printVertically(s string) []string {
	words := strings.Fields(s)
	maxLen := 0
	for _, word := range words {
		if len(word) > maxLen {
			maxLen = len(word)
		}
	}
	result := make([]string, maxLen)
	for i := 0; i < maxLen; i++ {
		for j := 0; j < len(words); j++ {
			if i < len(words[j]) {
				result[i] += string(words[j][i])
			} else if i > 0 {
				result[i] += " "
			}
		}
		result[i] = strings.TrimRight(result[i], " ")
	}
	return result
}