func findSneakyNumbers(n int) []int {
    sneakys := []int{}
    for i := 1; len(sneakys) < 2; i++ {
        if isSneaky(i) {
            sneakys = append(sneakys, i)
        }
    }
    return sneakys
}

func isSneaky(num int) bool {
    for num > 0 {
        digit := num % 10
        if digit == 0 || digit == 1 {
            return false
        }
        num /= 10
    }
    return true
}