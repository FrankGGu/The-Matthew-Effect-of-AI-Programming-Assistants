func nextGreaterElement(n int) int {
    digits := []byte(strconv.Itoa(n))
    i := len(digits) - 2
    for i >= 0 && digits[i] >= digits[i+1] {
        i--
    }
    if i < 0 {
        return -1
    }
    j := len(digits) - 1
    for j >= 0 && digits[j] <= digits[i] {
        j--
    }
    digits[i], digits[j] = digits[j], digits[i]
    reverse(digits[i+1:])
    res, _ := strconv.Atoi(string(digits))
    if res > math.MaxInt32 {
        return -1
    }
    return res
}

func reverse(digits []byte) {
    for i, j := 0, len(digits)-1; i < j; i, j = i+1, j-1 {
        digits[i], digits[j] = digits[j], digits[i]
    }
}