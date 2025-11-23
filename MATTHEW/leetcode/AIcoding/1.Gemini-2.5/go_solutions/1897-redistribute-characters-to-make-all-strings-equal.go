func makeEqual(words []string) bool {
	n := len(words)
	if n == 0 {
		return true // According to constraints, n will be at least 1.
	}

	// Create a frequency map (array) for all lowercase English letters.
	// Index 0 for 'a', 1 for 'b', ..., 25 for 'z'.
	counts := make([]int, 26)

	// Populate the counts by iterating through all words and their characters.
	for _, word := range words {
		for _, char := range word {
			counts[char-'a']++
		}
	}

	// Check if the count of each character is divisible by the number of words (n).
	// If it is, it means that character can be evenly distributed among all n strings.
	// If any character's count is not divisible by n, then it's impossible to make all strings equal.
	for _, count := range counts {
		if count%n != 0 {
			return false
		}
	}

	// If all character counts are divisible by n, then it's possible.
	return true
}