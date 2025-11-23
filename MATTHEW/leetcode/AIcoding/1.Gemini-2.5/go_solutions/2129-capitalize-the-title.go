import (
	"strings"
)

func capitalizeTitle(title string) string {
	words := strings.Fields(title)
	resultWords := make([]string, len(words))

	for i, word := range words {
		if len(word) <= 2 {
			resultWords[i] = strings.ToLower(word)
		} else {
			resultWords[i] = strings.ToUpper(string(word[0])) + strings.ToLower(word[1:])
		}
	}

	return strings.Join(resultWords, " ")
}