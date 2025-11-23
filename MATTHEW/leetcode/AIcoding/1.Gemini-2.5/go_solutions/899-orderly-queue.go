func orderlyQueue(s string, k int) string {
	if k == 1 {
		n := len(s)
		minStr := s
		currentStr := s
		for i := 0; i < n; i++ {