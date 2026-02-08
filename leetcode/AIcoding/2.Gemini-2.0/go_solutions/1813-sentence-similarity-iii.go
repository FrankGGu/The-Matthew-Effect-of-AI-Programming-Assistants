import (
	"strings"
)

func areSentencesSimilar(sentence1 string, sentence2 string) bool {
	words1 := strings.Split(sentence1, " ")
	words2 := strings.Split(sentence2, " ")

	n1 := len(words1)
	n2 := len(words2)

	i := 0
	j := 0

	for i < n1 && i < n2 && words1[i] == words2[i] {
		i++
	}

	for j < n1-i && j < n2-i && words1[n1-1-j] == words2[n2-1-j] {
		j++
	}

	return i+j == min(n1, n2)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}