func findTheDifference(s string, t string) byte {
	var diff byte = 0

	for i := 0; i < len(s); i++ {
		diff ^= s[i]
	}

	for i := 0; i < len(t); i++ {
		diff ^= t[i]
	}

	return diff
}