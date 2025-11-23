func sumBase(n int, k int) int {
    sum := 0
    for n > 0 {
        sum += n % k
        n = n / k
    }
    return sum
}