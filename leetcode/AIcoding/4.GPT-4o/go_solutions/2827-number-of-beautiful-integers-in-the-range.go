func beautifulIntegers(low int, high int, k int) int {
    count := 0
    for i := low; i <= high; i++ {
        if isBeautiful(i, k) {
            count++
        }
    }
    return count
}

func isBeautiful(n int, k int) bool {
    sum := 0
    for n > 0 {
        sum += n % 10
        n /= 10
    }
    return sum % k == 0
}