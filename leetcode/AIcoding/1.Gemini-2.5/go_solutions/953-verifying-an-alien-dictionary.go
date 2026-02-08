func isAlienSorted(words []string, order string) bool {
	orderMap := make(map[rune]int)
	for i, char := range order {
		orderMap[char] = i
	}

	// Helper function to compare two words based on the alien order.
	// Returns true if word1 is lexicographically less