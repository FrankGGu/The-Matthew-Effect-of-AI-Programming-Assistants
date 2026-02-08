func capitalizeTitle(title string) string {
    words := strings.Split(title, " ")
    for i, word := range words {
        if len(word) <= 2 {
            words[i] = strings.ToLower(word)
        } else {
            words[i] = strings.Title(strings.ToLower(word))
        }
    }
    return strings.Join(words, " ")
}