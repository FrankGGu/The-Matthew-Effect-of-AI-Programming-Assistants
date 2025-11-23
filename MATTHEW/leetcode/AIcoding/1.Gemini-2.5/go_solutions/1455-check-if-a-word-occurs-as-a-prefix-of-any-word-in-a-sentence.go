import "strings"

func isPrefixOfWord(sentence string, searchWord string) int {
	words := strings.Fields(sentence)
	for i, word := range words {
		if strings.HasPrefix(word, searchWord) {
			return i + 1
		}
	}
	return -1
}