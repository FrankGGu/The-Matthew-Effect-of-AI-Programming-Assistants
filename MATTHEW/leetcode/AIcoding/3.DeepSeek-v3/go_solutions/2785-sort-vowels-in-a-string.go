func sortVowels(s string) string {
    vowels := make([]rune, 0)
    for _, c := range s {
        if isVowel(c) {
            vowels = append(vowels, c)
        }
    }
    sort.Slice(vowels, func(i, j int) bool {
        return vowels[i] < vowels[j]
    })
    res := []rune(s)
    idx := 0
    for i, c := range res {
        if isVowel(c) {
            res[i] = vowels[idx]
            idx++
        }
    }
    return string(res)
}

func isVowel(c rune) bool {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
           c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U'
}