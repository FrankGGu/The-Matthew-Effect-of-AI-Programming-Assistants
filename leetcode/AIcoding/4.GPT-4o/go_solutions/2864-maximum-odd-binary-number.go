func maximumOddBinaryNumber(s string) string {
    countOne := 0
    for _, ch := range s {
        if ch == '1' {
            countOne++
        }
    }

    n := len(s)
    result := make([]byte, n)

    for i := 0; i < n-1; i++ {
        if countOne > 0 {
            result[i] = '1'
            countOne--
        } else {
            result[i] = '0'
        }
    }

    if countOne > 0 {
        result[n-1] = '1'
    } else {
        result[n-1] = '0'
    }

    return string(result)
}