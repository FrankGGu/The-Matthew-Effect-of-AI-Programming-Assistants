func partition(s string) [][]string {
	result := [][]string{}
	var backtrack func(start int, current []string)

	backtrack = func(start int, current []string) {
		if start == len(s) {
			temp := make([]string, len(current))
			copy(temp, current)
			result = append(result, temp)
			return
		}

		for i := start; i < len(s); i++ {
			sub := s[start : i+1]
			if isPalindrome(sub) {
				backtrack(i+1, append(current, sub))
			}
		}
	}

	backtrack(0, []string{})
	return result
}

func isPalindrome(s string) bool {
	left, right := 0, len(s)-1
	for left < right {
		if s[left] != s[right] {
			return false
		}
		left++
		right--
	}
	return true
}