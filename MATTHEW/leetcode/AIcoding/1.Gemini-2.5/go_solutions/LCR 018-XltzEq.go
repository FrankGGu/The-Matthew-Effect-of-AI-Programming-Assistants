func isPalindrome(s string) bool {
	left, right := 0, len(s)-1

	for left < right {
		// Move left pointer until it points to an alphanumeric character
		for left < right && !isAlphanumeric(rune(s[left])) {
			left++
		}
		// Move right pointer until it points to an alphanumeric character
		for left < right && !isAlphanumeric(rune(s[right])) {
			right--
		}

		// If characters are alphanumeric, compare them (case-insensitive)
		// Ensure pointers haven't crossed after skipping non-alphanumeric chars
		if left < right {
			charLeft := unicode.ToLower(rune(s[left]))
			charRight := unicode.ToLower(rune(s[right]))

			if charLeft != charRight {
				return false
			}

			left++
			right--
		}
	}

	return true
}

func isAlphanumeric(r rune) bool {
	return unicode.IsLetter(r) || unicode.IsDigit(r)
}