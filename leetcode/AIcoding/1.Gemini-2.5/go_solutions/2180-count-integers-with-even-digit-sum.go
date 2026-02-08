func countEven(num int) int {
    count := 0
    for i := 1; i <= num; i++ {
        if isEvenDigitSum(i) {
            count++
        }
    }
    return count
}

func isEvenDigitSum(n int) bool {
    sum := 0
    for n > 0 {
        sum += n % 10
        n /= 10
    }
    return sum % 2 == 0
}