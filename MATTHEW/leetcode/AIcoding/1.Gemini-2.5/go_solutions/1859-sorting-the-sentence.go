import (
	"strconv"
	"strings"
)

func sortSentence(s string) string {
	words := strings.Fields(s)
	result := make([]string, len(words))

	for _, word := range words {
		n := len(word)
		idx, _ := strconv.Atoi(string(word[n-1]))
		result[idx-1] = word[:n-1]
	}

	return strings.Join(result, " ")
}