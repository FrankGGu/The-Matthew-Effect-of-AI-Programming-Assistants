package main

func findSubstring(s string, words []string) []int {
	if len(words) == 0 {
		return []int{}
	}

	wordLen := len(words[0])
	totalWords := len(words)
	substrLen := wordLen * totalWords
	result := []int{}

	wordCount := make(map[string]int)
	for _, word := range words {
		wordCount[word]++
	}

	for i := 0; i <= len(s)-substrLen; i++ {
		seen := make(map[string]int)
		valid := true
		for j := 0; j < totalWords; j++ {
			start := i + j*wordLen
			end := start + wordLen
			word := s[start:end]
			if wordCount[word] == 0 {
				valid = false
				break
			}
			seen[word]++
			if seen[word] > wordCount[word] {
				valid = false
				break
			}
		}
		if valid {
			result = append(result, i)
		}
	}

	return result
}