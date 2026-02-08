func isPalindrome(s string) bool {
	for i := 0; i < len(s)/2; i++ {
		if s[i] != s[len(s)-i-1] {
			return false
		}
	}
	return true
}

func palindromePairs(words []string) [][]int {
	result := [][]int{}
	m := make(map[string]int)
	for i, word := range words {
		m[word] = i
	}

	for i, word := range words {
		for j := 0; j <= len(word); j++ {
			s1 := word[:j]
			s2 := word[j:]

			if isPalindrome(s1) {
				s1rv := reverseString(s2)
				if k, ok := m[s1rv]; ok && k != i {
					result = append(result, []int{k, i})
				}
			}

			if s2 != "" && isPalindrome(s2) {
				s2rv := reverseString(s1)
				if k, ok := m[s2rv]; ok && k != i {
					result = append(result, []int{i, k})
				}
			}
		}
	}

	return result
}

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}