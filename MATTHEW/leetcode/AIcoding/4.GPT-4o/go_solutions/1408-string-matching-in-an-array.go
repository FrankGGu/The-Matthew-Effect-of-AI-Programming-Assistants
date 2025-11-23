func stringMatching(words []string) []string {
    var result []string
    wordSet := make(map[string]struct{})

    for _, word := range words {
        wordSet[word] = struct{}{}
    }

    for _, word := range words {
        for _, other := range words {
            if word != other && strings.Contains(other, word) {
                result = append(result, word)
                break
            }
        }
    }

    return result
}