func longestStrChain(words []string) int {
    wordSet := make(map[string]struct{})
    for _, word := range words {
        wordSet[word] = struct{}{}
    }

    dp := make(map[string]int)

    var dfs func(string) int
    dfs = func(word string) int {
        if val, exists := dp[word]; exists {
            return val
        }
        maxLength := 1
        for i := 0; i < len(word); i++ {
            for j := 'a'; j <= 'z'; j++ {
                newWord := word[:i] + string(j) + word[i:]
                if _, exists := wordSet[newWord]; exists {
                    maxLength = max(maxLength, 1+dfs(newWord))
                }
            }
        }
        dp[word] = maxLength
        return maxLength
    }

    maxChainLength := 1
    for _, word := range words {
        maxChainLength = max(maxChainLength, dfs(word))
    }

    return maxChainLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}