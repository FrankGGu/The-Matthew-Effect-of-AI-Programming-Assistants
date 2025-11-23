func minimizeStringValue(s string) string {
	freq := make([]int, 26) // Frequency count for 'a' through 'z'

	// Count initial frequencies of non-'?' characters
	qIndices := []int{}
	for i, r := range s