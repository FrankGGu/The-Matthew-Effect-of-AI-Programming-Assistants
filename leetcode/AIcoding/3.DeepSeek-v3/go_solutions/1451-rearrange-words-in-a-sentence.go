import (
	"strings"
	"sort"
)

func arrangeWords(text string) string {
	words := strings.Split(text, " ")
	if len(words) == 0 {
		return text
	}
	words[0] = strings.ToLower(words[0])
	sort.SliceStable(words, func(i, j int) bool {
		return len(words[i]) < len(words[j])
	})
	if len(words) > 0 {
		words[0] = strings.Title(words[0])
	}
	return strings.Join(words, " ")
}