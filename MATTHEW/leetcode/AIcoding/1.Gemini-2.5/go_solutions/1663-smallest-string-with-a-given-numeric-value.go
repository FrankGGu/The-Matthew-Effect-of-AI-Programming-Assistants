func getSmallestString(n int, k int) string {
	res := make([]byte, n)

	// Iterate from right to left (end of the string to the beginning)
	for i := n - 1; i >= 0; i-- {
		// Calculate the maximum possible value for the current character.
		// It must