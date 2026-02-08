func countSpecialCharacters(s string) int {
    count := 0
    for _, ch := range s {
        if !isAlphanumeric(ch) {
            count++
        }
    }
    return count
}

func isAlphanumeric(ch rune) bool {
    return (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')
}