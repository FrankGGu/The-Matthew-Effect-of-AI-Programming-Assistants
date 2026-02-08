func findValidPairOfAdjacentDigits(s string) bool {
	if len(s) < 2 {
		return false
	}

	for i := 0; i < len(s)-1; i++ {
		if s[i] >= '0' && s[i] <= '9' && s[i+1] >= '0' && s[i+1] <= '9' {
			return true
		}
	}

	return false
}