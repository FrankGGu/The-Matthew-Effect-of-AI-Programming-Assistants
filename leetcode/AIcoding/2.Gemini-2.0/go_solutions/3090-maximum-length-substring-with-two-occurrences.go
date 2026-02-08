func maxLengthBetweenEqualCharacters(s string) int {
	ans := -1
	first := make([]int, 26)
	for i := range first {
		first[i] = -1
	}

	for i := 0; i < len(s); i++ {
		charIndex := int(s[i] - 'a')
		if first[charIndex] == -1 {
			first[charIndex] = i
		} else {
			ans = max(ans, i-first[charIndex]-1)
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}