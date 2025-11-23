func alternateDigitSum(n int) int {
    sum := 0
    sign := 1
    for n > 0 {
        sum += sign * (n % 10)
        n /= 10
        sign *= -1
    }
    return sum
}