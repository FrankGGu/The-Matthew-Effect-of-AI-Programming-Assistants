func freqAlphabets(s string) string {
    result := ""
    i := len(s) - 1

    for i >= 0 {
        if s[i] == '#' {
            num := int(s[i-2]-'0')*10 + int(s[i-1]-'0')
            result = string(rune(num + 'a' - 1)) + result
            i -= 3
        } else {
            num := int(s[i] - '0')
            result = string(rune(num + 'a' - 1)) + result
            i--
        }
    }

    return result
}