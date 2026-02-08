func reverseOnlyLetters(S string) string {
    runes := []rune(S)
    left, right := 0, len(runes)-1

    for left < right {
        if !isLetter(runes[left]) {
            left++
        } else if !isLetter(runes[right]) {
            right--
        } else {
            runes[left], runes[right] = runes[right], runes[left]
            left++
            right--
        }
    }
    return string(runes)
}

func isLetter(r rune) bool {
    return (r >= 'a' && r <= 'z') || (r >= 'A' && r <= 'Z')
}