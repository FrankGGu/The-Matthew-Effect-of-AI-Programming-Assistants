func smallestDivisibleDigitProduct(n int) int {
    for num := 1; ; num++ {
        if isValid(num, n) {
            return num
        }
    }
}

func isValid(num, n int) bool {
    if num == 0 {
        return false
    }
    product := 1
    temp := num
    for temp > 0 {
        digit := temp % 10
        if digit == 0 {
            return false
        }
        product *= digit
        temp /= 10
    }
    return product != 0 && product <= n && num%product == 0
}