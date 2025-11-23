package main

func uncommonFromSentences(A string, B string) []string {
    wordCount := make(map[string]int)
    wordsA := strings.Fields(A)
    wordsB := strings.Fields(B)

    for _, word := range wordsA {
        wordCount[word]++
    }

    for _, word := range wordsB {
        wordCount[word]++
    }

    var result []string
    for word, count := range wordCount {
        if count == 1 {
            result = append(result, word)
        }
    }

    return result
}