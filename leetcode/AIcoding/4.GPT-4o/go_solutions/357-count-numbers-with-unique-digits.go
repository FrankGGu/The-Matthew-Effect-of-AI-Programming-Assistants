func countNumbersWithUniqueDigits(n int) int {
    if n == 0 {
        return 1
    }
    if n > 10 {
        n = 10
    }
    total := 1
    uniqueDigits := 9
    availableDigits := 9
    for i := 1; i < n; i++ {
        total += uniqueDigits
        uniqueDigits *= availableDigits
        availableDigits--
    }
    return total
}