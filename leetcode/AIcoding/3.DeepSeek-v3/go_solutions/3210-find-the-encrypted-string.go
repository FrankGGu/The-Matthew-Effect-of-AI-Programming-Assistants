func encryptString(s string) string {
    if len(s) == 0 {
        return ""
    }
    var result strings.Builder
    currentChar := s[0]
    count := 1
    for i := 1; i < len(s); i++ {
        if s[i] == currentChar {
            count++
        } else {
            result.WriteString(fmt.Sprintf("%d%c", count, currentChar))
            currentChar = s[i]
            count = 1
        }
    }
    result.WriteString(fmt.Sprintf("%d%c", count, currentChar))
    return result.String()
}