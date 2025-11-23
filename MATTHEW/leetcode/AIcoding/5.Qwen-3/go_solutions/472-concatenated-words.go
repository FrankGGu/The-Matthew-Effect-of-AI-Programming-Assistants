package main

func findAllConcatenatedWordsInADictionary(words []string) []string {
    wordSet := make(map[string]bool)
    for _, word := range words {
        wordSet[word] = true
    }

    memo := make(map[string]bool)
    var dfs func(word string) bool
    dfs = func(word string) bool {
        if v, ok := memo[word]; ok {
            return v
        }
        for i := 1; i < len(word); i++ {
            prefix := word[:i]
            suffix := word[i:]
            if (wordSet[prefix] && dfs(suffix)) || (wordSet[prefix] && wordSet[suffix]) {
                memo[word] = true
                return true
            }
        }
        memo[word] = false
        return false
    }

    result := []string{}
    for _, word := range words {
        if dfs(word) {
            result = append(result, word)
        }
    }
    return result
}