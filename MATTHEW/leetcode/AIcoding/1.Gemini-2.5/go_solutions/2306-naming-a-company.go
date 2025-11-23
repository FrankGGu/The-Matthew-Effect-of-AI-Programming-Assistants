func distinctNames(ideas []string) int64 {
	// Step 1: Group suffixes by their first character.
	// `groups[char]` will be a set (map[string]bool) of suffixes for ideas starting with `char`.
	groups