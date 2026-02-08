func smallestNumber(num int64) string {
    digits := []byte(strconv.FormatInt(num, 10))
    if num <= 0 {
        sort.Slice(digits, func(i, j int) bool { return digits[i] > digits[j] })
        if digits[0] == '0' {
            return "0"
        }
        return string(digits)
    }
    sort.Slice(digits, func(i, j int) bool { return digits[i] < digits[j] })
    i := 0
    for i < len(digits) && digits[i] == '0' {
        i++
    }
    if i > 0 && i < len(digits) {
        digits[0], digits[i] = digits[i], digits[0]
    }
    return string(digits)
}