import "strings"

func mostWordsFound(sentences []string) int {
    maxWords := 0
    for _, sentence := range sentences {
        words := strings.Fields(sentence)
        currentWords := len(words)
        if currentWords > maxWords {
            maxWords = currentWords
        }
    }
    return maxWords
}