func countVowelSubstrings(s string, k int) int {
    vowels := "aeiou"
    vowelCount := make(map[rune]int)
    result := 0
    left := 0
    consonantCount := 0

    for right, char := range s {
        if strings.ContainsRune(vowels, char) {
            vowelCount[char]++
        } else {
            consonantCount++
        }

        for len(vowelCount) == 5 && consonantCount >= k {
            if strings.ContainsRune(vowels, rune(s[left])) {
                vowelCount[rune(s[left])]--
                if vowelCount[rune(s[left])] == 0 {
                    delete(vowelCount, rune(s[left]))
                }
            } else {
                consonantCount--
            }
            left++
        }
        if len(vowelCount) == 5 {
            result += left + 1
        }
    }
    return result
}