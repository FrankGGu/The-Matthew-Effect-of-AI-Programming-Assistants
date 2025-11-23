func longestPalindrome(words []string) int {
	count := make(map[string]int)
	ans := 0
	center := false

	for _, word := range words {
		if count[word] > 0 {
			ans += 4
			count[word]--
		} else {
			reversed := string([]rune{rune(word[1]), rune(word[0])})
			count[reversed]++
		}
	}

	for word := range count {
		if word[0] == word[1] && count[word] > 0 {
			center = true
			break
		}
	}

	if center {
		ans += 2
	}

	return ans
}