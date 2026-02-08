func countDigits(num int) int {
    count := 0
    tempNum := num

    for tempNum > 0 {
        digit := tempNum % 10
        if digit != 0 && num % digit == 0 {
            count++
        }
        tempNum /= 10
    }
    return count
}