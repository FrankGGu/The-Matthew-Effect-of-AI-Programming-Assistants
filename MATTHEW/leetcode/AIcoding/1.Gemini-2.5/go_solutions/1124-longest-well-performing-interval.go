func longestWPI(hours []int) int {
	n := len(hours)
	scores := make([]int, n)
	for i := 0; i < n; i++ {
		if hours[i] > 8 {
			scores[i] = 1
		} else {
			scores[i] =