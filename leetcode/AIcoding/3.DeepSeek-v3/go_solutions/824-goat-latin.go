func toGoatLatin(sentence string) string {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true, 'A': true, 'E': true, 'I': true, 'O': true, 'U': true}
    words := strings.Fields(sentence)
    for i, word := range words {
        first := word[0]
        if vowels[first] {
            word += "ma"
        } else {
            word = word[1:] + string(first) + "ma"
        }
        word += strings.Repeat("a", i+1)
        words[i] = word
    }
    return strings.Join(words, " ")
}