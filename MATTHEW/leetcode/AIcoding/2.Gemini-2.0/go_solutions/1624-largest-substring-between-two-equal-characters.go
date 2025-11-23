func maxLengthBetweenEqualCharacters(s string) int {
	firstIndex := make(map[rune]int)
	maxLength := -1
	for i, r := range s {
		if _, ok := firstIndex[r]; !ok {
			firstIndex[r] = i
		} else {
			length := i - firstIndex[r] - 1
			if length > maxLength {
				maxLength = length
			}
		}
	}
	return maxLength
}