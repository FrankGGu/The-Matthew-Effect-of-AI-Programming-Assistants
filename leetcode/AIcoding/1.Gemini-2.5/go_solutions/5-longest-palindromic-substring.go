func longestPalindrome(s string) string {
	if len(s) < 1 {
		return ""
	}

	start := 0
	end := 0

	for i := 0; i < len(s); i++ {
		// Palindromes with odd length (center is s[i])
		len1