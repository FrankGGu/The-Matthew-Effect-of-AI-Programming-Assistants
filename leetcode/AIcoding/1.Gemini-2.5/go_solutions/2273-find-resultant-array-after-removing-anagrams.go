func areAnagrams(s1, s2 string) bool {
	if len(s1) != len(s2) {
		return false
	}

	counts := [26]int{}

	for _, char := range s1 {
		counts[char-'a']++
	}

	for _, char := range s2 {
		counts[char-'a']--
	}

	for _, count := range counts {
		if count != 0 {
			return false
		}
	}

	return true
}

func removeAnagrams(words []string) []string {
	if len(words) == 0 {
		return []string{}
	}

	result := []string{words[0]}

	for i := 1; i < len(words); i++ {
		currentWord := words[i]
		lastKeptWord := result[len(result)-1]

		if !areAnagrams(currentWord, lastKeptWord) {
			result = append(result, currentWord)
		}
	}

	return result
}