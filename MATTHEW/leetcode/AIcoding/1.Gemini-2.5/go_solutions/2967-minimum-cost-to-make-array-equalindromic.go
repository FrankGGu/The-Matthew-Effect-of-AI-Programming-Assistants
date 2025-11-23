func isPalindrome(n int) bool {
	s := strconv.Itoa(n)
	l, r := 0, len(s)-1
	for l < r {
		if