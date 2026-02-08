func minimumSum(n int, k int) int {
    sum := 0
    count := 0
    for i := 1; count < n; i++ {
        if i%k != 0 && (i+k) > 0 {
            sum += i
            count++
        }
    }
    return sum
}