func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minDeletions(s string) int {
	n := len(s)
	bCount := 0
	ans := 0
	for i := 0; i < n; i++ {
		if s[i] == 'b' {
			bCount++
		} else {
			ans = min(ans+1, bCount)
		}
	}
	return ans
}