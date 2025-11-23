func longestPalindrome(words []string) int {
	count := make(map[string]int)
	ans := 0
	for _, word := range words {
		reversed := string([]rune{rune(word[1]), rune(word[0])})
		if count[reversed] > 0 {
			ans += 4
			count[reversed]--
		} else {
			count[word]++
		}
	}

	for word, cnt := range count {
		if word[0] == word[1] && cnt > 0 {
			ans += 2
			break
		}
	}
	return ans
}