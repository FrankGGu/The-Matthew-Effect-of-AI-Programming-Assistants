func lengthOfLongestSubstring(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}
	maxLength := 0
	start := 0
	charIndex := make(map[rune]int)

	for i, char := range s {
		if index, ok := charIndex[char]; ok && index >= start {
			start = index + 1
		}
		charIndex[char] = i
		currentLength := i - start + 1
		if currentLength > maxLength {
			maxLength = currentLength
		}
	}

	return maxLength
}