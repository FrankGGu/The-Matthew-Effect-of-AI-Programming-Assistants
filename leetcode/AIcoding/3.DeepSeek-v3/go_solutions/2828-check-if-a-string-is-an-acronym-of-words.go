func isAcronym(words []string, s string) bool {
    if len(words) != len(s) {
        return false
    }
    for i, word := range words {
        if len(word) == 0 || word[0] != s[i] {
            return false
        }
    }
    return true
}