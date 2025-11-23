package main

func countWords(words1 []string, words2 []string) int {
    wordCount := make(map[string]int)
    for _, word := range words1 {
        wordCount[word]++
    }
    result := 0
    for _, word := range words2 {
        if wordCount[word] == 1 {
            result++
        }
    }
    return result
}