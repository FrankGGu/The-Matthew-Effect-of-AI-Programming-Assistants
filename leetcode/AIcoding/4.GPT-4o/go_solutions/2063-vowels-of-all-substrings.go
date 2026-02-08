func countVowels(s string) int64 {
    vowels := "aeiou"
    count := int64(0)
    n := len(s)

    for i := 0; i < n; i++ {
        if strings.ContainsRune(vowels, rune(s[i])) {
            count += int64((i+1) * (n-i))
        }
    }

    return count
}