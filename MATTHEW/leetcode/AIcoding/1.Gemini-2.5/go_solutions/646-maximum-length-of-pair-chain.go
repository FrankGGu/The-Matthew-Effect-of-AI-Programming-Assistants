func findLongestChain(pairs [][]int) int {
	if len(pairs) == 0 {
		return 0
	}

	sort.Slice(pairs, func(i, j int) bool {
		// Sort pairs primarily by their end values.
		// If end values