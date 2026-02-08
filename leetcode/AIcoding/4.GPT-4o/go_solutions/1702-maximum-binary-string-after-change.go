func maximumBinaryString(binary string) string {
    countZero := 0
    for _, ch := range binary {
        if ch == '0' {
            countZero++
        }
    }

    if countZero == 0 {
        return binary
    }

    result := "1"
    for i := 0; i < len(binary)-countZero-1; i++ {
        result += "1"
    }
    for i := 0; i < countZero; i++ {
        result += "0"
    }

    return result
}