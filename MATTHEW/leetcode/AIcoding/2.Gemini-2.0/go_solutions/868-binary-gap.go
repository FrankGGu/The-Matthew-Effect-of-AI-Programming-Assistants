func binaryGap(n int) int {
	last := -1
	ans := 0
	for i := 0; n > 0; i++ {
		if n%2 == 1 {
			if last != -1 {
				ans = max(ans, i-last)
			}
			last = i
		}
		n /= 2
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}