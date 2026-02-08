func countIntegers(low int, high int) int {
    count := 0
    for i := low; i <= high; i++ {
        if isValid(i) {
            count++
        }
    }
    return count
}

func isValid(num int) bool {
    seen := make(map[int]bool)
    original := num
    for num > 0 {
        digit := num % 10
        if seen[digit] {
            return false
        }
        seen[digit] = true
        num /= 10
    }
    return true
}