func maximumOddBinaryNumber(s string) string {
    count := 0
    for _, ch := range s {
        if ch == '1' {
            count++
        }
    }
    res := make([]byte, len(s))
    for i := 0; i < len(s)-1; i++ {
        if count > 1 {
            res[i] = '1'
            count--
        } else {
            res[i] = '0'
        }
    }
    res[len(s)-1] = '1'
    return string(res)
}