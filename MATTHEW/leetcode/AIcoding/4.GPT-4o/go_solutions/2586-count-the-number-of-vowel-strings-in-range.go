func vowelStrings(words []string, left int, right int) int {
    count := 0
    vowels := "aeiou"

    for i := left; i <= right; i++ {
        word := words[i]
        if strings.Contains(vowels, string(word[0])) && strings.Contains(vowels, string(word[len(word)-1])) {
            count++
        }
    }

    return count
}