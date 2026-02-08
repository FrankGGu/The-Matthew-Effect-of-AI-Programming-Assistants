func arrangeWords(text string) string {
    words := strings.Fields(text)
    sort.Slice(words, func(i, j int) bool {
        return len(words[i]) < len(words[j])
    })
    for i := range words {
        words[i] = strings.ToLower(words[i])
    }
    words[0] = strings.Title(words[0])
    return strings.Join(words, " ")
}