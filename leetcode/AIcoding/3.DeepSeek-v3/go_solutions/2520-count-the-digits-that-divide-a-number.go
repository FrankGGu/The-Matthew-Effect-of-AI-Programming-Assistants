func countDigits(num int) int {
    count := 0
    original := num
    for num > 0 {
        digit := num % 10
        if digit != 0 && original % digit == 0 {
            count++
        }
        num /= 10
    }
    return count
}