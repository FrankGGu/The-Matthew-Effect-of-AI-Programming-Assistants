func capitalizeTitle(title string) string {
    words := strings.Fields(title)
    for i, word := range words {
        if len(word) > 2 {
            words[i] = strings.ToUpper(string(word[0])) + strings.ToLower(word[1:])
        } else {
            words[i] = strings.ToLower(word)
        }
    }
    return strings.Join(words, " ")
}