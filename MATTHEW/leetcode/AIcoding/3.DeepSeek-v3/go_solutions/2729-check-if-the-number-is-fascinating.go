func isFascinating(n int) bool {
    if n > 333 {
        return false
    }
    concatenated := strconv.Itoa(n) + strconv.Itoa(2*n) + strconv.Itoa(3*n)
    if len(concatenated) != 9 {
        return false
    }
    digits := make([]bool, 10)
    for _, ch := range concatenated {
        if ch == '0' {
            return false
        }
        d := int(ch - '0')
        if digits[d] {
            return false
        }
        digits[d] = true
    }
    return true
}