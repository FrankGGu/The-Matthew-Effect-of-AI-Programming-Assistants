func plusOne(digits []int) []int {
    n := len(digits)

    for i := n - 1; i >= 0; i-- {
        if digits[i] < 9 {
            digits[i]++
            return digits
        }
        digits[i] = 0
    }

    // If we reach here, it means all digits were 9s (e.g., [9,9,9])
    // We need to add a leading 1
    newDigits := make([]int, n+1)
    newDigits[0] = 1
    // The rest of the elements in newDigits will be 0 by default, which is correct.
    return newDigits
}