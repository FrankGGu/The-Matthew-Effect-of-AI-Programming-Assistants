func getSmallestString(n int, k int) string {
	res := make([]byte, n)
	for i := 0; i < n; i++ {
		val := min(26, k-n+i+1)
		res[n-i-1] = byte('a' + val - 1)
		k -= val
	}
	return string(res)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}