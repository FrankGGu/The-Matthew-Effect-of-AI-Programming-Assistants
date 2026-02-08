func findSubstring(s string, words []string) []int {
	if len(s) == 0 || len(words) == 0 {
		return []int{}
	}

	wordLen := len(words[0])
	totalLen := wordLen * len(words)
	result := []int{}

	wordCount := make(map[string]int)
	for _, word := range words {
		wordCount[word]++
	}

	for i := 0; i <= len(s)-totalLen; i++ {
		seen := make(map[string]int)
		match := true
		for j := 0; j < len(words); j++ {
			word := s[i+j*wordLen : i+(j+1)*wordLen]
			seen[word]++

			if wordCount[word] == 0 || seen[word] > wordCount[word] {
				match = false
				break
			}
		}

		if match {
			result = append(result, i)
		}
	}

	return result
}