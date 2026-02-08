func arrangeWords(text string) string {
	words := strings.Split(text, " ")
	filteredWords := make([]string, 0)
	spaces := 0
	for _, word := range words {
		if word != "" {
			filteredWords = append(filteredWords, word)
		} else {
			spaces++
		}
	}

	wordCount := len(filteredWords)

	if wordCount == 1 {
		return strings.Title(strings.ToLower(filteredWords[0])) + strings.Repeat(" ", spaces)
	}

	spaceBetween := spaces / (wordCount - 1)
	extraSpaces := spaces % (wordCount - 1)

	result := strings.Title(strings.ToLower(filteredWords[0]))
	for i := 1; i < wordCount; i++ {
		result += strings.Repeat(" ", spaceBetween) + strings.ToLower(filteredWords[i])
	}

	result += strings.Repeat(" ", extraSpaces)

	return result
}