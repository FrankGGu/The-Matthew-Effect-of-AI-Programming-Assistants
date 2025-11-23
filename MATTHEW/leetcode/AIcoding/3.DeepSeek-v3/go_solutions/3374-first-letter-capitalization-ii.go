func capitalizeTitle(title string) string {
    words := strings.Split(title, " ")
    for i, word := range words {
        if len(word) <= 2 {
            words[i] = strings.ToLower(word)
        } else {
            words[i] = strings.ToUpper(string(word[0])) + strings.ToLower(word[1:])
        }
    }
    return strings.Join(words, " ")
}