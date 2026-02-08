func findTheLongestBalancedSubstring(s string) int {
	maxLen := 0
	for i := 0; i < len(s); i++ {
		zeros := 0
		ones := 0
		for j := i; j < len(s); j++ {
			if s[j] == '0' {
				zeros++
			} else {
				ones++
			}
			if zeros == ones {
				maxLen = max(maxLen, 2*zeros)
			} else if ones > zeros {
				break
			}
		}
	}
	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}