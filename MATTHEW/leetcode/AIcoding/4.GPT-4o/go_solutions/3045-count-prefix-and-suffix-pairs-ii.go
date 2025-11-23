func countPrefixAndSuffixPairs(words []string) int {
    count := 0
    wordSet := make(map[string]struct{})

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