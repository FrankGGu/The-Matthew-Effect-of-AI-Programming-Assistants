func minimumLength(s string) int {
	left := 0
	right := len(s) - 1

	for left < right && s[left] == s[right] {
		char := s[left]

		for left <= right && s[left] == char {
			left++
		}

		for left <= right && s[right] == char {
			right--
		}
	}

	if left > right {
		return 0
	}
	return right - left + 1
}