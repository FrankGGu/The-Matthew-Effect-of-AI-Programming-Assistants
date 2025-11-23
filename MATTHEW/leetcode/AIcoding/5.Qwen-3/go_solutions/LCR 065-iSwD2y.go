package main

func minimumLengthEncoding(words []string) int {
    wordSet := make(map[string]bool)
    for _, word := range words {
        wordSet[word] = true
    }

    for word := range wordSet {
        for i := 1; i < len(word); i++ {
            delete(wordSet, word[i:])
        }
    }

    length := 0
    for word := range wordSet {
        length += len(word) + 1
    }

    return length
}