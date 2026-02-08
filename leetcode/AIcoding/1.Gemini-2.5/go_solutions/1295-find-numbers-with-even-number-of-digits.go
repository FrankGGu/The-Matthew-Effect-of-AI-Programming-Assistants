func findNumbers(nums []int) int {
    evenDigitCount := 0
    for _, num := range nums {
        digits := 0
        tempNum := num
        for tempNum > 0 {
            tempNum /= 10
            digits++
        }
        if digits % 2 == 0 {
            evenDigitCount++
        }
    }
    return evenDigitCount
}