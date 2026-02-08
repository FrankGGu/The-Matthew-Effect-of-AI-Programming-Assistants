func removeTrailingZeros(num string) string {
    i := len(num) - 1
    for i >= 0 && num[i] == '0' {
        i--
    }
    return num[:i+1]
}