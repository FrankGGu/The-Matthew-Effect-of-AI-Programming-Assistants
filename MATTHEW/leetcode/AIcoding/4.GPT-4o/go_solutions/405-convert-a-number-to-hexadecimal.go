func toHex(num int) string {
    if num == 0 {
        return "0"
    }
    hexChars := "0123456789abcdef"
    result := ""
    for num != 0 {
        result = string(hexChars[num&15]) + result
        num >>= 4
    }
    return result
}