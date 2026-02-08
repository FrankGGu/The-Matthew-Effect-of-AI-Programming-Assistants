func countSpecialCharacters(s string) int {
    count := 0
    for _, char := range s {
        if !isAlphaNumeric(char) {
            count++
        }
    }
    return count
}

func isAlphaNumeric(char rune) bool {
    return (char >= '0' && char <= '9') || (char >= 'A' && char <= 'Z') || (char >= 'a' && char <= 'z')
}