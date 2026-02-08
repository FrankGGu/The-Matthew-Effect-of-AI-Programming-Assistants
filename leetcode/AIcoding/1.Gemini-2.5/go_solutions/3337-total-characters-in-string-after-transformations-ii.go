func totalCharacters(s string, k int) int {
	currentSum := 0

	// First transformation: convert string to initial sum
	for _, char := range s {
		val := int(char - 'a' + 1)
		// Add digits of val to currentSum
		if val < 10