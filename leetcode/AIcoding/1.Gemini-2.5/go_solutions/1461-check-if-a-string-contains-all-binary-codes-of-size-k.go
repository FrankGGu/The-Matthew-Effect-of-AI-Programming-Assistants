func hasAllCodes(s string, k int) bool {
	if len(s) < k {
		return false
	}

	seen := make(map[int]bool)
	currentCode := 0
	mask := (1 << k) - 1 // A bitmask to keep only the last