func uniqueLetterString(s string) int {
	n := len(s)
	left := make([]int, n)
	right := make([]int, n)
	lastPos := make(map[rune]int)

	for i := 0; i < n; i++ {
		if pos, ok := lastPos[rune(s[i])]; ok {
			left[i] = i - pos
		} else {
			left[i] = i + 1
		}
		lastPos[rune(s[i])] = i
	}

	lastPos = make(map[rune]int)
	for i := n - 1; i >= 0; i-- {
		if pos, ok := lastPos[rune(s[i])]; ok {
			right[i] = pos - i
		} else {
			right[i] = n - i
		}
		lastPos[rune(s[i])] = i
	}

	ans := 0
	for i := 0; i < n; i++ {
		ans += left[i] * right[i]
	}

	return ans
}