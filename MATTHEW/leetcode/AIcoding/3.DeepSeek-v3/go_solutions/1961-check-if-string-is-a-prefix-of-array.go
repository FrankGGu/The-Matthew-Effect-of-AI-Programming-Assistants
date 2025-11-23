func isPrefixString(s string, words []string) bool {
    built := ""
    for _, word := range words {
        built += word
        if built == s {
            return true
        }
        if len(built) > len(s) {
            return false
        }
    }
    return built == s
}