func maxOperations(s string) int {
	n := len(s)
	totalOperations := 0
	onesCount := 0 // Stores the count of '1's encountered so far (from left to right)

	// Iterate through the string, stopping before the last character
	// because an operation requires s[i] == '1'