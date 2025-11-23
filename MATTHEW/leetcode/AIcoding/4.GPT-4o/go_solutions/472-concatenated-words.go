package main

import "sort"

func findAllConcatenatedWordsInADict(words []string) []string {
    wordSet := make(map[string]struct{})
    for _, word := range words {
        wordSet[word] = struct{}{}
    }

    var result []string
    sort.Slice(words, func(i, j int) bool {
        return len(words[i]) < len(words[j])
    })

    for _, word := range words {
        if canForm(word, wordSet) {
            result = append(result, word)
        }
        wordSet[word] = struct{}{}
    }

    return result
}

func canForm(word string, wordSet map[string]struct{}) bool {
    dp := make([]bool, len(word)+1)
    dp[0] = true

    for i := 1; i <= len(word); i++ {
        for j := 0; j < i; j++ {
            if dp[j] && inSet(word[j:i], wordSet) {
                dp[i] = true
                break
            }
        }
    }

    return dp[len(word)]
}

func inSet(word string, wordSet map[string]struct{}) bool {
    _, exists := wordSet[word]
    return exists
}