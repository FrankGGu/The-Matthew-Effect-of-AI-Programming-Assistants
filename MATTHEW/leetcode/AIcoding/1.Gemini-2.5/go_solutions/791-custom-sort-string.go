func customSortString(order string, s string) string {
	counts := make([]int, 26) // Frequency map for characters in s

	// Populate frequency map for characters in s
	for _, char := range s {
		counts[char-'a']++
	}

	var result strings.Builder
	result.Grow(len(s)) // Pre-allocate memory for efficiency

	// Append characters according to the 'order' string
	for _, char := range order {
		for counts[char-'a'] > 0 {
			result.WriteRune(char)
			counts[char-'a']--
		}
	}

	// Append any remaining characters from 's' that were not in 'order'
	// They are appended in their original alphabetical order as a side effect of iterating 'a' through 'z'
	for i := 0; i < 26; i++ {
		char := rune('a' + i)
		for counts[i] > 0 {
			result.WriteRune(char)
			counts[i]--
		}
	}

	return result.String()
}