func reverseVowels(s string) string {
	chars := []byte(s)
	left := 0
	right := len(chars) - 1

	for left < right {
		for left < right && !isVowel(chars[left]) {
			left++
		}
		for left < right && !isVowel(chars[right]) {
			right--
		}

		if left < right {
			chars[left], chars[right] = chars[right], chars[left]
			left++
			right--
		}
	}

	return string(chars)
}

func isVowel(char byte) bool {
	switch char {
	case 'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U':
		return true
	default:
		return false
	}
}