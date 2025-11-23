func minCut(s string) int {
	n := len(s)
	if n <= 1 {
		return 0
	}

	// isPalindrome[i][j] will be true if substring s[i...j] is a palindrome.
	isPalindrome := make([][]bool, n)
	for i := range is