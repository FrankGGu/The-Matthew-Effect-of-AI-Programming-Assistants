func countPrefixAndSuffixPairs(words []string) int {
    wordSet := make(map[string]struct{})
    count := 0

    for _, word := range words {
        wordSet[word] = struct{}{}
    }

    for _, word := range words {
        for i := 1; i < len(word); i++ {
            prefix := word[:i]
            suffix := word[i:]
            if _, exists := wordSet[prefix]; exists {
                count++
            }
            if _, exists := wordSet[suffix]; exists {
                count++
            }
        }
    }

    return count
}