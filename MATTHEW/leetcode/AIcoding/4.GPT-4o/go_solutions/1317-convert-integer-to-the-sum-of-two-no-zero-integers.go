func getNoZeroIntegers(n int) []int {
    for i := 1; i < n; i++ {
        a, b := i, n-i
        if !containsZero(a) && !containsZero(b) {
            return []int{a, b}
        }
    }
    return nil
}

func containsZero(num int) bool {
    for num > 0 {
        if num%10 == 0 {
            return true
        }
        num /= 10
    }
    return false
}