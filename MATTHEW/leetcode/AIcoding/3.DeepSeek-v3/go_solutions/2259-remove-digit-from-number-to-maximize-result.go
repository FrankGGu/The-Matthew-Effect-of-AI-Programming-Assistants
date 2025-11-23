func removeDigit(number string, digit byte) string {
    res := ""
    for i := 0; i < len(number); i++ {
        if number[i] == digit {
            current := number[:i] + number[i+1:]
            if res == "" || current > res {
                res = current
            }
        }
    }
    return res
}