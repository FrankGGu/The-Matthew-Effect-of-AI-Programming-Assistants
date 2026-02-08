import (
	"strings"
)

func mostCommonWord(paragraph string, banned []string) string {
	bannedMap := make(map[string]bool)
	for _, word := range banned {
		bannedMap[word] = true
	}

	normalizedParagraph := strings.ToLower(paragraph)
	words := strings.FieldsFunc(normalizedParagraph, func(r rune) bool {
		return !('a' <= r && r <= 'z')
	})

	wordCounts := make(map[string]int)
	for _, word := range words {
		if !bannedMap[word] {
			wordCounts[word]++
		}
	}

	mostCommon := ""
	maxCount := 0
	for word, count := range wordCounts {
		if count > maxCount {
			mostCommon = word
			maxCount = count
		}
	}

	return mostCommon
}