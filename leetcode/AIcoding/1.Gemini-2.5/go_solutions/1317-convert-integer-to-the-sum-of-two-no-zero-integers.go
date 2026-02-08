func getNoZeroIntegers(n int) []int {
    for a := 1; a < n; a++ {
        b := n - a
        if isNoZero(a) && isNoZero(b) {
            return []int{a, b}
        }
    }
    return nil
}

func isNoZero(num int) bool {
    for num > 0 {
        if num % 10 == 0 {
            return false
        }
        num /= 10
    }
    return true
}