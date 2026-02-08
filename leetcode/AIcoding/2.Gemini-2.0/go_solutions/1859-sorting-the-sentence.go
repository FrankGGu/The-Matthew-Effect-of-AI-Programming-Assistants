import (
	"sort"
	"strings"
)

func sortSentence(s string) string {
	words := strings.Split(s, " ")
	sortedWords := make([]string, len(words))

	for _, word := range words {
		index := int(word[len(word)-1] - '1')
		sortedWords[index] = word[:len(word)-1]
	}

	return strings.Join(sortedWords, " ")
}