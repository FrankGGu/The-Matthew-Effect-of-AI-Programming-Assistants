func countDigitOne(n int) int {
    if n <= 0 {
        return 0
    }
    count := 0
    factor := 1
    for i := 0; i < 10; i++ {
        lowerNumbers := n - (n / factor) * factor
        currentDigit := (n / factor) % 10
        higherNumbers := n / (factor * 10)

        if currentDigit == 0 {
            count += higherNumbers * factor
        } else if currentDigit == 1 {
            count += higherNumbers*factor + lowerNumbers + 1
        } else {
            count += (higherNumbers + 1) * factor
        }

        factor *= 10
    }
    return count
}