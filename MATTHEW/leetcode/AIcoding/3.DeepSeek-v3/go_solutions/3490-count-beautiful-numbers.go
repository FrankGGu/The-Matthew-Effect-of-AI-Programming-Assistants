func countBeautifulNumbers(n int) int {
    count := 0
    for num := 1; num <= n; num++ {
        digits := strconv.Itoa(num)
        firstDigit := int(digits[0] - '0')
        lastDigit := int(digits[len(digits)-1] - '0')
        if gcd(firstDigit, lastDigit) == 1 {
            count++
        }
    }
    return count
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}