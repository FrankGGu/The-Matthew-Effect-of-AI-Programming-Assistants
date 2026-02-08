func lastSubstring(s string) string {
    maxChar := 'a'
    maxIdx := 0
    n := len(s)

    for i := 0; i < n; i++ {
        if s[i] > byte(maxChar) {
            maxChar = rune(s[i])
            maxIdx = i
        } else if s[i] == byte(maxChar) {
            if s[maxIdx:] < s[i:] {
                maxIdx = i
            }
        }
    }
    return s[maxIdx:]
}