func titleToNumber(columnTitle string) int {
    result := 0
    for _, ch := range columnTitle {
        result = result * 26 + int(ch - 'A' + 1)
    }
    return result
}