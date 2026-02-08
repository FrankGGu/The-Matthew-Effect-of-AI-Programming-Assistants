func mostWordsFound(sentences []string) int {
    maxWords := 0
    for _, sentence := range sentences {
        words := strings.Fields(sentence)
        if len(words) > maxWords {
            maxWords = len(words)
        }
    }
    return maxWords
}