func countNumbersWithUniqueDigits(n int) int {
    if n == 0 {
        return 1
    }
    res := 10
    uniqueDigits := 9
    availableNumbers := 9
    for i := 2; i <= n && availableNumbers > 0; i++ {
        uniqueDigits *= availableNumbers
        res += uniqueDigits
        availableNumbers--
    }
    return res
}