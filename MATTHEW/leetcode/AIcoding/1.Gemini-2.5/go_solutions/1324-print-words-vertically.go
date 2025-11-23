func printVertically(s string) []string {
	words := strings.Fields(s)

	maxLength := 0
	for _, word := range words {
		if len(word) > maxLength {
			maxLength = len(word)
		}
	}

	result := make([]string, maxLength)

	for i := 0; i < maxLength; i++ {
		var currentRow strings.Builder
		for j := 0; j < len(words); j++ {
			if i < len(words[j]) {
				currentRow.WriteByte(words[j][i])
			} else {
				currentRow.WriteByte(' ')
			}
		}
		result[i] = strings.TrimRight(currentRow.String(), " ")
	}

	return result
}