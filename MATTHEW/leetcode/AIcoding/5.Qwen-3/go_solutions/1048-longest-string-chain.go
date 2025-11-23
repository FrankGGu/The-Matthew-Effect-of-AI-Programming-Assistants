package main

func longestStrChain(words []string) int {
    sort.Slice(words, func(i, j int) bool {
        return len(words[i]) < len(words[j])
    })

    dp := make(map[string]int)
    maxLen := 0

    for _, word := range words {
        dp[word] = 1
        for i := 0; i < len(word); i++ {
            prev := word[:i] + word[i+1:]
            if val, ok := dp[prev]; ok {
                dp[word] = max(dp[word], val+1)
            }
        }
        maxLen = max(maxLen, dp[word])
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}