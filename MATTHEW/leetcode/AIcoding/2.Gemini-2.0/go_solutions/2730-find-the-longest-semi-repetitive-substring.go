func longestSemiRepetitiveSubstring(s string) int {
	n := len(s)
	ans := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			sub := s[i : j+1]
			count := 0
			for k := 0; k < len(sub)-1; k++ {
				if sub[k] == sub[k+1] {
					count++
				}
			}
			if count <= 1 {
				ans = max(ans, len(sub))
			}
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