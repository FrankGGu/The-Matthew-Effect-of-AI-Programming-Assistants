func f(s string) int {
	if len(s) == 0 {
		return 0
	}

	// Initialize minCharVal to a value greater than any lowercase English letter.
	// This ensures the first character