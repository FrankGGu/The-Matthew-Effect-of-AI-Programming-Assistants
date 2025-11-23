func decodeAtIndex(S string, K int) string {
    length := 0
    for i := 0; i < len(S); i++ {
        if unicode.IsDigit(rune(S[i])) {
            length *= int(S[i] - '0')
        } else {
            length++
        }
    }

    for i := len(S) - 1; i >= 0; i-- {
        K %= length
        if K == 0 && !unicode.IsDigit(rune(S[i])) {
            return string(S[i])
        }
        if unicode.IsDigit(rune(S[i])) {
            length /= int(S[i] - '0')
        } else {
            length--
        }
    }
    return ""
}