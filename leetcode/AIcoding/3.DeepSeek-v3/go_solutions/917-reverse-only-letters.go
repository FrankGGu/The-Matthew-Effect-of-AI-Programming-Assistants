func reverseOnlyLetters(s string) string {
    bytes := []byte(s)
    left, right := 0, len(bytes)-1
    for left < right {
        for left < right && !isLetter(bytes[left]) {
            left++
        }
        for left < right && !isLetter(bytes[right]) {
            right--
        }
        if left < right {
            bytes[left], bytes[right] = bytes[right], bytes[left]
            left++
            right--
        }
    }
    return string(bytes)
}

func isLetter(c byte) bool {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
}