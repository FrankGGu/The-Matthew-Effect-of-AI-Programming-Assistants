func rotatedDigits(N int) int {
    count := 0
    for i := 1; i <= N; i++ {
        if isValid(i) {
            count++
        }
    }
    return count
}

func isValid(num int) bool {
    valid := false
    for num > 0 {
        digit := num % 10
        if digit == 3 || digit == 4 || digit == 7 {
            return false
        }
        if digit == 2 || digit == 5 || digit == 6 || digit == 9 {
            valid = true
        }
        num /= 10
    }
    return valid
}