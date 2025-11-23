package main

func arrangeWords(s string) string {
    words := strings.Fields(s)
    for i := 0; i < len(words); i++ {
        words[i] = strings.ToLower(words[i])
    }
    sort.Slice(words, func(i, j int) bool {
        return len(words[i]) < len(words[j])
    })
    result := strings.Join(words, " ")
    return strings.Title(result)
}