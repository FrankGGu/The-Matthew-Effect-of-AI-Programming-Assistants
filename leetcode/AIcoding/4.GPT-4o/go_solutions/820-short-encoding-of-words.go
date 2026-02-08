func minimumLengthEncoding(words []string) int {
    suffixSet := make(map[string]struct{})
    for _, word := range words {
        for i := 1; i < len(word); i++ {
            suffixSet[word[i:]] = struct{}{}
        }
    }
    ans := 0
    for _, word := range words {
        if _, exists := suffixSet[word]; !exists {
            ans += len(word) + 1
        }
    }
    return ans
}