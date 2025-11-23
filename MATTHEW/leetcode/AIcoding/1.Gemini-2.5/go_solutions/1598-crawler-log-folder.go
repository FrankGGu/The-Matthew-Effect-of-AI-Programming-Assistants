func minOperations(logs []string) int {
	depth := 0
	for _, log := range logs {
		if log == "../" {
			if depth > 0 {
				depth--
			}
		} else if log == "./" {
			// Stay in the current folder, depth remains unchanged
		} else { // It's a child folder, e.g., "x/"
			depth++
		}
	}
	return depth
}