func alternateDigitSum(n int) int {
    sum := 0
    sign := 1
    for n > 0 {
        digit := n % 10
        sum += sign * digit
        sign *= -1
        n /= 10
    }
    if sign == 1 {
        sum = -sum
    }
    return sum
}