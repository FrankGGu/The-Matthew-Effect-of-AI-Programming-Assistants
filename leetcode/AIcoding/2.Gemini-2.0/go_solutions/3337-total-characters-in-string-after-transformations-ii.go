func totalCharacters(words []string) int {
	count := 0
	for _, word := range words {
		count += len(word)
	}
	return count
}