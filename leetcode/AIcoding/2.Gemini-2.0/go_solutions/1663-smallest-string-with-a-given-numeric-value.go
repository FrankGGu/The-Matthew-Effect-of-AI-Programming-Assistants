func getSmallestString(n int, k int) string {
	res := make([]byte, n)
	for i := n - 1; i >= 0; i-- {
		val := min(26, k-i)
		res[i] = byte('a' + val - 1)
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