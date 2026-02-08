func shortestPalindrome(s string) string {
	n := len(s)
	if n <= 1 {
		return s
	}

	// s_rev is the reversed string of s
	runes := []rune(s)
	for i, j := 0,