func ambiguousCoordinates(s string) []string {
	n := len(s)
	// Remove parentheses
	s = s[1 : n-1]
	n = len(s)

	var result []string

	// Helper function to generate all valid number strings from a substring
	// e.g., "123"