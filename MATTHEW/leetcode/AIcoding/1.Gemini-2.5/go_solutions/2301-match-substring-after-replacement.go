func matchReplacement(s string, sub string, mappings [][]byte) bool {
	canReplace := [256][256]bool{}

	// Initialize canReplace: a character can always replace itself
	for i := 0; i < 256; i++ {
		canReplace[i][i] = true