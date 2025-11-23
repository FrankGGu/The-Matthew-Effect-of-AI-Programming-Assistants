func isPrefixString(s string, words []string) bool {
    prefix := ""
    for _, word := range words {
        prefix += word
        if prefix == s {
            return true
        }
        if len(prefix) > len(s) {
            break
        }
    }
    return false
}