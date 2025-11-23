func halvesAreAlike(s string) bool {
    n := len(s)
    mid := n / 2
    vowels := "aeiouAEIOU"
    count := 0

    for i := 0; i < mid; i++ {
        if strings.ContainsRune(vowels, rune(s[i])) {
            count++
        }
        if strings.ContainsRune(vowels, rune(s[i+mid])) {
            count--
        }
    }

    return count == 0
}