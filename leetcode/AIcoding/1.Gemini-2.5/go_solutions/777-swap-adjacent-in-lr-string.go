func canTransform(start string, end string) bool {
	n := len(start)
	if n != len(end) {
		return false
	}

	i, j := 0, 0
	for i < n && j < n {
		// Skip 'X' characters in start string
		for