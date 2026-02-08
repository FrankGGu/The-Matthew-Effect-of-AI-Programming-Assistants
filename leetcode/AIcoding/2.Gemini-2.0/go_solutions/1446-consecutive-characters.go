func maxPower(s string) int {
	maxLen := 1
	currLen := 1
	for i := 1; i < len(s); i++ {
		if s[i] == s[i-1] {
			currLen++
			if currLen > maxLen {
				maxLen = currLen
			}
		} else {
			currLen = 1
		}
	}
	return maxLen
}