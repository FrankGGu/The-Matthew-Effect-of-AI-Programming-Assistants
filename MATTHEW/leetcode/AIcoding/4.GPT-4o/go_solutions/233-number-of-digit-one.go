func countDigitOne(n int) int {
    if n <= 0 {
        return 0
    }

    count := 0
    factor := 1
    for i := 1; i <= n; i *= 10 {
        lowerNumbers := n - (n / i) * i
        currentDigit := (n / i) % 10
        higherNumbers := n / (i * 10)

        if currentDigit == 0 {
            count += higherNumbers * i
        } else if currentDigit == 1 {
            count += higherNumbers * i + lowerNumbers + 1
        } else {
            count += (higherNumbers + 1) * i
        }
    }
    return count
}