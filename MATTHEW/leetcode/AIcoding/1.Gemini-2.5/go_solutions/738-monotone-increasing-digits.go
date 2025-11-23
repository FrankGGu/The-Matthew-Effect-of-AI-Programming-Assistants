func monotoneIncreasingDigits(n int) int {
	s := []byte(strconv.Itoa(n))
	length := len(s)

	// Find the first position from the right where s[i] > s[i+1]
	// This marks the starting point for modification.