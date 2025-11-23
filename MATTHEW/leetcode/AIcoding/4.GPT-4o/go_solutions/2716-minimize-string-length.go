func minimizeStringLength(s string) int {
    charSet := make(map[rune]struct{})
    for _, char := range s {
        charSet[char] = struct{}{}
    }
    return len(charSet)
}