func reformatNumber(number string) string {
    digits := make([]rune, 0)
    for _, ch := range number {
        if ch >= '0' && ch <= '9' {
            digits = append(digits, ch)
        }
    }
    n := len(digits)
    var res []rune
    i := 0
    for n - i > 4 {
        res = append(res, digits[i:i+3]...)
        res = append(res, '-')
        i += 3
    }
    if n - i == 4 {
        res = append(res, digits[i:i+2]...)
        res = append(res, '-')
        res = append(res, digits[i+2:i+4]...)
    } else {
        res = append(res, digits[i:]...)
    }
    return string(res)
}