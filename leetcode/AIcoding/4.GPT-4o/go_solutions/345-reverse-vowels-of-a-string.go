func reverseVowels(s string) string {
    vowels := "aeiouAEIOU"
    str := []rune(s)
    left, right := 0, len(str)-1

    for left < right {
        if !strings.ContainsRune(vowels, str[left]) {
            left++
            continue
        }
        if !strings.ContainsRune(vowels, str[right]) {
            right--
            continue
        }
        str[left], str[right] = str[right], str[left]
        left++
        right--
    }

    return string(str)
}