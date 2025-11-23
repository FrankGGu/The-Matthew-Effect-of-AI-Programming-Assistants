func findReplaceString(s string, indices []int, sources []string, targets []string) string {
	// Step 1: Create a map to store valid replacements.
	// The key is the starting index in 's'.
	// The value is a struct containing the