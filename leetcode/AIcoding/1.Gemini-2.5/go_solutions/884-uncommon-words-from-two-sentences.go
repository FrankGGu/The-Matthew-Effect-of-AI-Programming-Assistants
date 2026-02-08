import (
	"strings"
)

func uncommonFromSentences(s1 string, s2 string) []string {
	wordCounts := make(map[string]int)

	words1 := strings.Fields(s1)
	for _, word := range words1 {
		wordCounts[word]++
	}

	words2 := strings.Fields(s2)
	for _, word := range words2 {
		wordCounts[word]++
	}

	var uncommonWords []string
	for word, count := range wordCounts {
		if count == 1 {
			uncommonWords = append(uncommonWords, word)
		}
	}

	return uncommonWords
}