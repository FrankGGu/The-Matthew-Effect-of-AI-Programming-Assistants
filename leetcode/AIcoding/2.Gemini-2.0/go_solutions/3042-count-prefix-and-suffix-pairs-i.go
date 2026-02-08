func countPrefixSuffixPairs(words []string) int {
	count := 0
	for i := 0; i < len(words); i++ {
		for j := i + 1; j < len(words); j++ {
			if isPrefixAndSuffix(words[i], words[j]) {
				count++
			}
		}
	}
	return count
}

func isPrefixAndSuffix(word1, word2 string) bool {
	if len(word1) > len(word2) {
		return false
	}

	isPrefix := true
	for i := 0; i < len(word1); i++ {
		if word1[i] != word2[i] {
			isPrefix = false
			break
		}
	}

	isSuffix := true
	for i := 0; i < len(word1); i++ {
		if word1[i] != word2[len(word2)-len(word1)+i] {
			isSuffix = false
			break
		}
	}

	return isPrefix && isSuffix
}