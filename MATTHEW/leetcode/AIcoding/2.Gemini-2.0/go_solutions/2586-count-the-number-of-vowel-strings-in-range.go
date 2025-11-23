func vowelStrings(words []string, left int, right int) int {
	count := 0
	for i := left; i <= right; i++ {
		word := words[i]
		if len(word) > 0 {
			first := word[0]
			last := word[len(word)-1]
			if (first == 'a' || first == 'e' || first == 'i' || first == 'o' || first == 'u') &&
				(last == 'a' || last == 'e' || last == 'i' || last == 'o' || last == 'u') {
				count++
			}
		}
	}
	return count
}