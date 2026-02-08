func replaceDigits(s string) string {
    result := []byte(s)
    for i := 1; i < len(s); i += 2 {
        result[i] = result[i-1] + byte(s[i]-'0')
    }
    return string(result)
}