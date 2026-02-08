package main

func capitalizeTitle(s string) string {
    words := strings.Fields(s)
    for i, word := range words {
        if len(word) <= 2 {
            words[i] = strings.ToLower(word)
        } else {
            words[i] = strings.ToLower(word[:1]) + strings.ToLower(word[1:])
        }
    }
    return strings.Join(words, " ")
}