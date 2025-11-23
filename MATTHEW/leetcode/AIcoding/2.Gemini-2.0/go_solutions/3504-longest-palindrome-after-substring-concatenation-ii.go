func longestPalindrome(words []string) int {
	count := make(map[string]int)
	ans := 0
	central := false
	for _, w := range words {
		if count[w] > 0 {
			ans += 4
			count[w]--
		} else {
			reversed := string([]byte{w[1], w[0]})
			count[reversed]++
		}
	}

	for w, c := range count {
		if w[0] == w[1] && c > 0 {
			central = true
			break
		}
	}

	if central {
		ans += 2
	}

	return ans
}