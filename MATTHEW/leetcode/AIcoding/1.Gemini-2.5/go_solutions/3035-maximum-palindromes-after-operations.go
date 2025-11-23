func maxPalindromesAfterOperations(words []string) int {
	// 1. Count character frequencies across all words.
	charCounts := make(map[rune]int)
	for _, word := range words {
		for _, char := range word {
			charCounts[char]