func findAndReplacePattern(words []string, pattern string) []string {
    result := []string{}

    for _, word := range words {
        if match(word, pattern) {
            result = append(result, word)
        }
    }

    return result
}

func match(