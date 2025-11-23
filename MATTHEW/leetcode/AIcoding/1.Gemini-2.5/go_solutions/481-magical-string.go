func magicalString(n int) int {
	if n <= 0 {
		return 0
	}
	if n <= 3 {
		return 1
	}

	// s will store the magical string characters.
	// We use a byte slice for efficiency.
	// We pre-allocate to avoid reallocations, size