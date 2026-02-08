func longestContinuousSubstring(s string) int {
	if len(s) == 0 {
		return 0
	}
	maxLen := 1
	currLen := 1
	for i := 1; i < len(s); i++ {
		if s[i] == s[i-1]+1 {
			currLen++
		} else {
			if currLen > maxLen {
				maxLen = currLen
			}
			currLen = 1
		}
	}
	if currLen > maxLen {
		maxLen = currLen
	}
	return maxLen
}