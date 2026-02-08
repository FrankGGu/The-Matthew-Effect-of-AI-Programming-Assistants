func maxPower(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	maxP := 1
	currentP := 1

	for i := 1; i < n; i++ {
		if s[i] == s[i-1] {
			currentP++
		} else {
			if currentP > maxP {
				maxP = currentP
			}
			currentP = 1
		}
	}

	if currentP > maxP {
		maxP = currentP
	}

	return maxP
}