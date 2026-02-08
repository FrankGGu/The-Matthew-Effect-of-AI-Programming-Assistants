func breakPalindrome(palindrome string) string {
	n := len(palindrome)
	if n == 1 {
		return ""
	}

	s := []byte(palindrome)

	for i := 0; i < n/2; i++ {
		if s[i] != 'a' {
			s[i] = 'a'
			return string(s)
		}
	}

	// If we reach here, it means all characters in the first half are 'a'.
	// Since it's a palindrome, the string must consist of all 'a's (e.g., "aaa", "aaaa").
	// To make it lexicographically smallest non-palindrome, we must change the last character to 'b'.
	s[n-1] = 'b'
	return string(s)
}