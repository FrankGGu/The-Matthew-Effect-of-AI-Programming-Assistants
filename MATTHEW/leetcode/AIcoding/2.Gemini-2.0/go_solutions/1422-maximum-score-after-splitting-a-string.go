func maxScore(s string) int {
	n := len(s)
	max := 0
	for i := 1; i < n; i++ {
		left := s[:i]
		right := s[i:]
		score := 0
		for _, c := range left {
			if c == '0' {
				score++
			}
		}
		for _, c := range right {
			if c == '1' {
				score++
			}
		}
		if score > max {
			max = score
		}
	}
	return max
}