func longestSubstring(s string, k int) int {
	if len(s) == 0 {
		return 0
	}

	count := make(map[rune]int)
	for _, r := range s {
		count[r]++
	}

	for r, c := range count {
		if c < k {
			ans := 0
			start := 0
			for i, rr := range s {
				if rr == r {
					ans = max(ans, longestSubstring(s[start:i], k))
					start = i + 1
				}
			}
			ans = max(ans, longestSubstring(s[start:], k))
			return ans
		}
	}

	return len(s)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}