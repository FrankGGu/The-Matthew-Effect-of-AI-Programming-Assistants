func findDifferentBinaryString(nums []string) string {
	n := len(nums)
	var resultBuilder strings.Builder
	resultBuilder.Grow(n) // Pre-allocate capacity for efficiency

	// This approach uses Cantor's diagonalization argument.
	// We construct a