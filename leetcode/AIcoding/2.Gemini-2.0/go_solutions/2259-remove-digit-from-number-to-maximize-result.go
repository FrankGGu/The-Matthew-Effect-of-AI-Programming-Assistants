func removeDigit(number string, digit byte) string {
    res := ""
    for i := 0; i < len(number); i++ {
        if number[i] == digit {
            temp := number[:i] + number[i+1:]
            if res == "" || temp > res {
                res = temp
            }
        }
    }
    return res
}