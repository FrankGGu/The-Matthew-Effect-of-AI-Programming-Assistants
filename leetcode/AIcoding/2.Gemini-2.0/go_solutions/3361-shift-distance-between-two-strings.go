func shiftDistance(s string, t string) int {
	n := len(s)
	for i := 0; i < n; i++ {
		shifted := s[i:] + s[:i]
		if shifted == t {
			return i
		}
	}
	return -1
}