func numSplits(s string) int {
	n := len(s)
	if n <= 1 {
		return 0
	}

	leftUnique := make([]int, n)
	rightUnique := make([]int, n)

	seenLeft := make([]bool, 26)
	count := 0
	for i := 0; i < n; i++ {
		charIndex := s[i] - 'a'
		if !seenLeft[charIndex] {
			seenLeft[charIndex] = true
			count++
		}
		leftUnique[i] = count
	}

	seenRight := make([]bool, 26)
	count = 0
	for i := n - 1; i >= 0; i-- {
		charIndex := s[i] - 'a'
		if !seenRight[charIndex] {
			seenRight[charIndex] = true
			count++
		}
		rightUnique[i] = count
	}

	goodSplits := 0
	for i := 0; i < n-1; i++ {
		if leftUnique[i] == rightUnique[i+1] {
			goodSplits++
		}
	}

	return goodSplits
}