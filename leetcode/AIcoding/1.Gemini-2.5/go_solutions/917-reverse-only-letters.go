func reverseOnlyLetters(s string) string {
	chars := []byte(s)
	left, right := 0, len(chars)-1

	for left < right {
		// Move left pointer past non-letters
		for left < right && !isLetter(chars[left]) {
			left++
		}
		// Move right pointer past non-letters
		for left < right && !isLetter(chars[right]) {
			right--
		}

		// If both pointers found letters and haven't crossed
		if left < right {
			// Swap letters
			chars[left], chars[right] = chars[right], chars[left]
			left++
			right--
		}
	}

	return string(chars)
}