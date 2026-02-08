func findAllConcatenatedWordsInADict(words []string) []string {
    wordSet := make(map[string]struct{})
    for _, word := range words {
        if len(word) > 0 {
            wordSet[word] = struct{}{}
        }
    }

    var res []string
    for _, word := range words {
        if len(word) == 0 {
            continue
        }
        if canForm(word, wordSet) {
            res = append(res, word)
        }
    }
    return res
}

func canForm(word string, wordSet map[string]struct{}) bool {
    dp := make([]bool, len(word)+1)
    dp[0] = true
    for i := 1; i <= len(word); i++ {
        for j := 0; j < i; j++ {
            if !dp[j] {
                continue
            }
            if j == 0 && i == len(word) {
                continue
            }
            if _, exists := wordSet[word[j:i]]; exists {
                dp[i] = true
                break
            }
        }
    }
    return dp[len(word)]
}