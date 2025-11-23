func maximumSwap(num int) int {
    digits := []byte(strconv.Itoa(num))
    maxIdx := len(digits) - 1
    swapLeft, swapRight := -1, -1

    for i := len(digits) - 1; i >= 0; i-- {
        if digits[i] > digits[maxIdx] {
            maxIdx = i
        } else if digits[i] < digits[maxIdx] {
            swapLeft, swapRight = i, maxIdx
        }
    }

    if swapLeft != -1 {
        digits[swapLeft], digits[swapRight] = digits[swapRight], digits[swapLeft]
    }

    result, _ := strconv.Atoi(string(digits))
    return result
}