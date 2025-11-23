func distributeCandies(n int, limit int) int {
	ans := 0
	for i := 0; i <= limit; i++ {
		remaining := n - i
		if remaining >= 0 {
			minJ := max(0, remaining-limit)
			maxJ := min(limit, remaining)
			ans += maxJ - minJ + 1
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

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}