func maximumNumberOfStringPairs(words []string) int {
	pairs := 0
	seen := make(map[string]bool)

	for _, word := range words {
		// For a 2-character string, reversing is simple: swap characters.
		reversedWord := string(word[1]) + string(word[0])