package main

func longestWord(wordList []string) string {
    sort.Strings(wordList)
    wordSet := make(map[string]bool)
    for _, word := range wordList {
        wordSet[word] = true
    }
    result := ""
    for _, word := range wordList {
        if len(word) < len(result) {
            continue
        }
        valid := true
        for i := 1; i < len(word); i++ {
            if !wordSet[word[:i]] {
                valid = false
                break
            }
        }
        if valid {
            if len(word) > len(result) || (len(word) == len(result) && word < result) {
                result = word
            }
        }
    }
    return result
}