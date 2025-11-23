func distributeCandies(n int, limit int) int64 {
	var ans int64
	for i := 0; i <= min(n, limit); i++ {
		remaining := n - i
		low := max(0, remaining-limit)
		high := min(limit, remaining)
		ans += int64(high - low + 1)
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}