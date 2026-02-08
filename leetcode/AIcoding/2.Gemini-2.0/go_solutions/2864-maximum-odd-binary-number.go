func maximumOddBinaryNumber(s string) string {
    ones := 0
    for _, char := range s {
        if char == '1' {
            ones++
        }
    }
    result := make([]byte, len(s))
    for i := 0; i < ones-1; i++ {
        result[i] = '1'
    }
    for i := ones-1; i < len(s)-1; i++ {
        result[i] = '0'
    }
    result[len(s)-1] = '1'
    return string(result)
}