func isPalindrome(s string) bool {
	left := 0
	right := len(s) - 1

	for left < right {
		// Move left pointer until it points to an alphanumeric character
		for left < right && !unicode.IsLetter(rune(s[left])) && !unicode.IsDigit(rune(s[left])) {
			left++
		}
		// Move right pointer until it points to an alphanumeric character
		for left < right && !unicode.IsLetter(rune(s[right]))