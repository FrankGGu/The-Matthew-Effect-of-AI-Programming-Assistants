func toGoatLatin(S string) string {
    words := strings.Split(S, " ")
    vowels := "aeiouAEIOU"
    for i, word := range words {
        if strings.ContainsAny(string(word[0]), vowels) {
            words[i] = word + "ma" + strings.Repeat("a", i+1)
        } else {
            words[i] = word[1:] + string(word[0]) + "ma" + strings.Repeat("a", i+1)
        }
    }
    return strings.Join(words, " ")
}