func longestStrChain(words []string) int {
    sort.Slice(words, func(i, j int) bool {
        return len(words[i]) < len(words[j])
    })

    dp := make(map[string]int)
    maxChain := 0

    for _, word := range words {
        currentMax := 0
        for i := 0; i < len(word); i++ {
            predecessor := word[:i] + word[i+1:]
            if val, exists := dp[predecessor]; exists {
                if val > currentMax {
                    currentMax = val
                }
            }
        }
        dp[word] = currentMax + 1
        if dp[word] > maxChain {
            maxChain = dp[word]
        }
    }
    return maxChain
}