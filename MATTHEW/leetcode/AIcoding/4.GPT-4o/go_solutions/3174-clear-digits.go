func clearDigits(num string) string {
    result := ""
    for _, ch := range num {
        if ch >= '0' && ch <= '9' {
            result += string(ch)
        }
    }
    return result
}