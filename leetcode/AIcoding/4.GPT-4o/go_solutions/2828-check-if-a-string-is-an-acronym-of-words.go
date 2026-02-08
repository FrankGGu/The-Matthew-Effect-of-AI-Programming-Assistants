func isAcronym(words []string, s string) bool {
    acronym := ""
    for _, word := range words {
        acronym += string(word[0])
    }
    return acronym == s
}