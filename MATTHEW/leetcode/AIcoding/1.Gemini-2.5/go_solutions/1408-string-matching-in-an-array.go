import "strings"

func stringMatching(words []string) []string {
	resultMap := make(map[string]bool)

	for i := 0; i < len(words); i++ {
		word1 := words[i]
		for j := 0; j < len(words); j++ {
			word2 := words[j]
			if word1 != word2 && strings.Contains(word2, word1) {
				resultMap[word1] = true
			}
		}
	}

	resultSlice := []string{}
	for word := range resultMap {
		resultSlice = append(resultSlice, word)
	}

	return resultSlice
}