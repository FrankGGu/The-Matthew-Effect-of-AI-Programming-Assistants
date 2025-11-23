func isValid(word string) bool {
    if len(word) < 3 {
        return false
    }
    hasVowel := false
    hasConsonant := false
    for _, c := range word {
        if !unicode.IsLetter(c) && !unicode.IsDigit(c) {
            return false
        }
        lower := unicode.ToLower(c)
        if lower == 'a' || lower == 'e' || lower == 'i' || lower == 'o' || lower == 'u' {
            hasVowel = true
        } else if unicode.IsLetter(c) {
            hasConsonant = true
        }
    }
    return hasVowel && hasConsonant
}