func reverseWords(s string) string {
    words := strings.Fields(s)
    for i, word := range words {
        runes := []rune(word)
        for j, k := 0, len(runes)-1; j < k; j, k = j+1, k-1 {
            runes[j], runes[k] = runes[k], runes[j]
        }
        words[i] = string(runes)
    }
    return strings.Join(words, " ")
}