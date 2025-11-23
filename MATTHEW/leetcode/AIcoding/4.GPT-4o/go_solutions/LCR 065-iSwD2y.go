func compress(words []string) int {
    wordSet := make(map[string]struct{})
    for _, word := range words {
        wordSet[word] = struct{}{}
    }
    return len(wordSet)
}