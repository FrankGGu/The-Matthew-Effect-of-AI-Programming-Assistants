import (
	"sort"
	"strings"
)

func arrangeWords(text string) string {
	words := strings.Split(text, " ")
	words[0] = strings.ToLower(words[0])

	sort.Slice(words, func(i, j int) bool {
		return len(words[i]) < len(words[j])
	})

	result := strings.Join(words, " ")
	result = strings.ToUpper(string(result[0])) + result[1:]

	return result
}