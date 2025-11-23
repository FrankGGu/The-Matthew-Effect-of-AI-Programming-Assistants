func countPrefixes(words []string, s string) int {
    count := 0
    for _, word := range words {
        if len(word) <= len(s) && s[:len(word)] == word {
            count++
        }
    }
    return count
}