func diStringMatch(s string) []int {
	n := len(s)
	result := make([]int, n+1)
	low := 0
	high := n
	for i := 0; i < n; i++ {
		if s[i] == 'I' {
			result[i] = low
			low++
		} else {
			result[i] = high
			high--
		}
	}
	result[n] = low
	return result
}