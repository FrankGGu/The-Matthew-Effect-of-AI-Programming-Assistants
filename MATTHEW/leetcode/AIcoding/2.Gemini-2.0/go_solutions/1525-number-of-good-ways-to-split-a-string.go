func numDistinct(s string) int {
	n := len(s)
	left := make(map[rune]bool)
	right := make(map[rune]bool)
	rightCounts := make(map[rune]int)

	for _, r := range s {
		rightCounts[r]++
		right[r] = true
	}

	count := 0
	for i := 0; i < n-1; i++ {
		r := rune(s[i])
		left[r] = true
		rightCounts[r]--

		if rightCounts[r] == 0 {
			delete(right, r)
		}

		if len(left) == len(right) {
			count++
		}
	}

	return count
}