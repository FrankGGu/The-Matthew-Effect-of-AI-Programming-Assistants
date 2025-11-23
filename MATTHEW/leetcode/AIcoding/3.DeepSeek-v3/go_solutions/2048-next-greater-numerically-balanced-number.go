func nextBeautifulNumber(n int) int {
    for i := n + 1; ; i++ {
        if isBeautiful(i) {
            return i
        }
    }
}

func isBeautiful(num int) bool {
    count := make([]int, 10)
    for num > 0 {
        digit := num % 10
        if digit == 0 || digit > len(count) {
            return false
        }
        count[digit]++
        num /= 10
    }
    for i := 1; i < len(count); i++ {
        if count[i] != 0 && count[i] != i {
            return false
        }
    }
    return true
}