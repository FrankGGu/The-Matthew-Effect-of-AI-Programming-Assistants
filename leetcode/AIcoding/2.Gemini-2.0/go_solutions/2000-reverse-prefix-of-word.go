func reversePrefix(word string, ch byte) string {
	index := -1
	for i := 0; i < len(word); i++ {
		if word[i] == ch {
			index = i
			break
		}
	}
	if index == -1 {
		return word
	}

	runes := []rune(word)
	for i, j := 0, index; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}

	return string(runes)
}