func vowelStrings(words []string, queries [][]int) []int {
	n := len(words)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		if isVowelString(words[i]) {
			prefixSum[i+1] = prefixSum[i] + 1
		} else {
			prefixSum[i+1] = prefixSum[i]
		}
	}

	result := make([]int, len(queries))
	for i := 0; i < len(queries); i++ {
		start := queries[i][0]
		end := queries[i][1]
		result[i] = prefixSum[end+1] - prefixSum[start]
	}

	return result
}

func isVowelString(s string) bool {
	vowels := "aeiou"
	if len(s) == 0 {
		return false
	}
	first := s[0]
	last := s[len(s)-1]

	isFirstVowel := false
	for _, v := range vowels {
		if first == byte(v) {
			isFirstVowel = true
			break
		}
	}

	isLastVowel := false
	for _, v := range vowels {
		if last == byte(v) {
			isLastVowel = true
			break
		}
	}

	return isFirstVowel && isLastVowel
}