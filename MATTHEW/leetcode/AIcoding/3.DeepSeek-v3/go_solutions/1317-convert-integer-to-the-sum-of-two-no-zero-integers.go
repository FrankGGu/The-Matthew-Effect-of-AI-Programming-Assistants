func getNoZeroIntegers(n int) []int {
    for a := 1; a < n; a++ {
        b := n - a
        if !containsZero(a) && !containsZero(b) {
            return []int{a, b}
        }
    }
    return []int{}
}

func containsZero(num int) bool {
    for num > 0 {
        digit := num % 10
        if digit == 0 {
            return true
        }
        num /= 10
    }
    return false
}