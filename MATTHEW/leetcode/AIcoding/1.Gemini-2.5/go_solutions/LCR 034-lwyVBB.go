func isAlienSorted(words []string, order string) bool {
	// Create character to order index mapping
	// Using a slice of size 26 for 'a' through 'z' for efficiency
	orderMap := make([]int, 26)
	for i, char := range order {
		orderMap[char-'a