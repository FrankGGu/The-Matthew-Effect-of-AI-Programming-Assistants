func balancedString(s string) int {
	n := len(s)
	target := n / 4

	charMap := map[byte]int{'Q': 0, 'W': 1, 'E': 2, 'R': 3}

	totalCounts := [4]int{}
	for i := 0; i < n; i++ {
		totalCounts[charMap[s[i]]]++
	}

	isAlreadyBalanced := true
	for i := 0; i < 4; i++ {
		if totalCounts[i] != target {
			isAlreadyBalanced = false
			break
		}
	}
	if isAlreadyBalanced {
		return 0
	}

	minLen := n
	left := 0
	windowCounts := [4]int{}

	check := func() bool {
		for i := 0; i < 4; i++ {
			if totalCounts[i]-windowCounts[i] > target {
				return false
			}
		}
		return true
	}

	for right := 0; right < n; right++ {
		windowCounts[charMap[s[right]]]++

		for check() {
			minLen = min(minLen, right-left+1)
			windowCounts[charMap[s[left]]]--
			left++
		}
	}

	return minLen
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}