func vowelStrings(words []string, left int, right int) int {
	isVowel := func(char byte) bool {
		return char == 'a' || char == 'e' || char == 'i' || char == 'o' || char == 'u'
	}

	count := 0
	for i := left; i <= right; i++ {
		word := words[i]
		if isVowel(word[0]) && isVowel(word[len(word)-1]) {
			count++
		}
	}
	return count
}