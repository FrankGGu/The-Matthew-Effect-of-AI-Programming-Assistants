func lengthOfLongestSubstring(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}
	maxLength := 0
	start := 0
	charIndexMap := make(map[byte]int)

	for end := 0; end < n; end++ {
		char := s[end]
		if index, ok := charIndexMap[char]; ok && index >= start {
			start = index + 1
		}
		charIndexMap[char] = end
		currentLength := end - start + 1
		if currentLength > maxLength {
			maxLength = currentLength
		}
	}
	return maxLength
}