func countBeautifulNumbers(low int, high int) int {
    count := 0
    for i := low; i <= high; i++ {
        if isBeautiful(i) {
            count++
        }
    }
    return count
}

func isBeautiful(num int) bool {
    sum := 0
    for num > 0 {
        sum += num % 10
        num /= 10
    }
    return sum%2 == 0
}