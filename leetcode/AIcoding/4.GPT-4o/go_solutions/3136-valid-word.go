func isValidWord(word string, validWords []string) bool {
    wordMap := make(map[string]bool)
    for _, v := range validWords {
        wordMap[v] = true
    }
    return wordMap[word]
}