func canConstruct(s string, k int) bool {
	n := len(s)

	// If k is greater than the length of s, we cannot form k non-empty palindromes.
	// Each palindrome must have at least one character.
	if k > n {
		return false
	}

	// If k is