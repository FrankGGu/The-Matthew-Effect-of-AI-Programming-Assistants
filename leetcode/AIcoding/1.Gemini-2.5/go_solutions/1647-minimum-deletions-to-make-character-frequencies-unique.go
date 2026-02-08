func minDeletions(s string) int {
	// Step 1: Count character frequencies
	// Using an array of size 26 for lowercase English letters
	counts := [26]int{}
	for _, char := range s {
		counts[char-'a']++
	}

	// Step 2: