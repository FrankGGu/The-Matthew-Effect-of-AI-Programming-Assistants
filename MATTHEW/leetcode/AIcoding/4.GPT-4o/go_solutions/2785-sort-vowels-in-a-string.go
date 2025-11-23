func sortVowels(s string) string {
    vowels := []rune{}
    for _, c := range s {
        if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
           c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U' {
            vowels = append(vowels, c)
        }
    }

    sort.Slice(vowels, func(i, j int) bool {
        return vowels[i] < vowels[j]
    })

    result := []rune(s)
    j := 0
    for i, c := range result {
        if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
           c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U' {
            result[i] = vowels[j]
            j++
        }
    }

    return string(result)
}