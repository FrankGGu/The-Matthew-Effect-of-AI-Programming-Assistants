func reverseWords(s string) string {
    words := strings.Split(s, " ")
    for i := range words {
        runes := []rune(words[i])
        for j, k := 0, len(runes)-1; j < k; j, k = j+1, k-1 {
            runes[j], runes[k] = runes[k], runes[j]
        }
        words[i] = string(runes)
    }
    return strings.Join(words, " ")
}