func longestNiceSubstring(s string) string {
	if len(s) < 2 {
		return ""
	}

	// Step 1: Build a set of characters present in the current string s.
	// Using a boolean array for ASCII chars