func countKReducibleNumbers(N int, K int) int {
    count := 0
    for i := 1; i < N; i++ {
        if isKReducible(i, K) {
            count++
        }
    }
    return count
}

func isKReducible(num int, K int) bool {
    for num > 0 {
        if num%10 > K {
            return false
        }
        num /= 10
    }
    return true
}