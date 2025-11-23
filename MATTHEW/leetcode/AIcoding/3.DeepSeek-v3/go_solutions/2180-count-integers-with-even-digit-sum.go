func countEven(num int) int {
    count := 0
    for i := 1; i <= num; i++ {
        sum := 0
        n := i
        for n > 0 {
            sum += n % 10
            n /= 10
        }
        if sum % 2 == 0 {
            count++
        }
    }
    return count
}