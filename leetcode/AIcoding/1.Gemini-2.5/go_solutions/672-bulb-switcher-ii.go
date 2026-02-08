func flipLights(n int, m int) int {
	if m == 0 {
		return 1
	}

	if n == 1 {
		return 2
	}
	if n == 2 {
		if m == 1 {
			return 4
		}
		// m >= 2
		return 4
	}
	// n >= 3
	if m == 1 {
		return 5
	}
	if m == 2 {
		return 8
	}
	// m >= 3
	return 8
}