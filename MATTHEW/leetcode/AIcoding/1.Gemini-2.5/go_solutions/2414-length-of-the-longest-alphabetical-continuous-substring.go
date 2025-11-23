func longestContinuousSubstring(s string) int {
	if len(s) == 0 {
		return 0
	}

	maxLength := 1
	currentLength := 1

	for i := 1; i < len(s); i++ {
		if s[i] == s[i-1]+1 {
			currentLength++
		} else {
			currentLength = 1
		}
		if currentLength > maxLength {
			maxLength = currentLength
		}
	}

	return maxLength
}