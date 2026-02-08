func countDigitOne(n int) int {
	count := 0
	for i := 1; i <= n; i *= 10 {
		divider := i * 10
		count += (n / divider) * i
		count += min(max(n%divider-i+1, 0), i)
	}
	return count
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