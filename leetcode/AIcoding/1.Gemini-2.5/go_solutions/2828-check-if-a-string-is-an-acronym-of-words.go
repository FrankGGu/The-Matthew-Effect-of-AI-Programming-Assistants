func isAcronym(words []string, s string) bool {
    if len(s) != len(words) {
        return false
    }

    for i := 0; i < len(words); i++ {
        if words[i][0] != s[i] {
            return false
        }
    }

    return true
}