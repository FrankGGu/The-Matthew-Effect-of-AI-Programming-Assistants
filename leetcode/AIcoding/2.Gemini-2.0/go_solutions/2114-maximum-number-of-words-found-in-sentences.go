import "strings"

func mostWordsFound(sentences []string) int {
	maxWords := 0
	for _, sentence := range sentences {
		words := strings.Split(sentence, " ")
		numWords := len(words)
		if numWords > maxWords {
			maxWords = numWords
		}
	}
	return maxWords
}