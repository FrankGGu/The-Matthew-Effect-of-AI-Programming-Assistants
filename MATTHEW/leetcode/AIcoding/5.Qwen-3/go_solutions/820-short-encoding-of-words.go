package main

func encodeWords(words []string) int {
    wordSet := make(map[string]bool)
    for _, word := range words {
        wordSet[word] = true
    }
    for word := range wordSet {
        for i := 1; i < len(word); i++ {
            delete(wordSet, word[i:])
        }
    }
    res := 0
    for word := range wordSet {
        res += len(word) + 1
    }
    return res
}