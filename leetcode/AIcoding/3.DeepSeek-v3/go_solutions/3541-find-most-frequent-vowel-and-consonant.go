func findMostFrequentVowelAndConsonant(s string) []string {
    vowels := map[rune]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    vowelCount := make(map[rune]int)
    consonantCount := make(map[rune]int)

    for _, c := range strings.ToLower(s) {
        if c >= 'a' && c <= 'z' {
            if vowels[c] {
                vowelCount[c]++
            } else {
                consonantCount[c]++
            }
        }
    }

    maxVowel := 'a'
    maxVowelCount := 0
    for v, cnt := range vowelCount {
        if cnt > maxVowelCount || (cnt == maxVowelCount && v < maxVowel) {
            maxVowel = v
            maxVowelCount = cnt
        }
    }

    maxConsonant := 'b'
    maxConsonantCount := 0
    for c, cnt := range consonantCount {
        if cnt > maxConsonantCount || (cnt == maxConsonantCount && c < maxConsonant) {
            maxConsonant = c
            maxConsonantCount = cnt
        }
    }

    result := make([]string, 2)
    if maxVowelCount > 0 {
        result[0] = string(maxVowel)
    } else {
        result[0] = ""
    }
    if maxConsonantCount > 0 {
        result[1] = string(maxConsonant)
    } else {
        result[1] = ""
    }

    return result
}