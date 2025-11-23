func partition(s string) [][]string {
	result := [][]string{}
	var backtrack func(int, []string)

	isPalindrome := func(str string) bool {
		l, r := 0, len(str)-1
		for l < r {
			if str[l] != str[r] {
				return false
			}
			l++
			r--
		}
		return true
	}

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