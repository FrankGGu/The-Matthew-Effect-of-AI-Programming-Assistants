func countValidWords(sentence string) int {
    words := strings.Fields(sentence)
    count := 0
    for _, word := range words {
        if isValid(word) {
            count++
        }
    }
    return count
}

func isValid(word string) bool {
    hyphenCount := 0
    n := len(word)
    for i, c := range word {
        if c >= '0' && c <= '9' {
            return false
        }
        if c == '-' {
            if i == 0 || i == n-1 {
                return false
            }
            if !isLetter(word[i-1]) || !isLetter(word[i+1]) {
                return false
            }
            hyphenCount++
            if hyphenCount > 1 {
                return false
            }
        }
        if (c == '!' || c == '.' || c == ',') && i != n-1 {
            return false
        }
    }
    return true
}

func isLetter(c byte) bool {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
}