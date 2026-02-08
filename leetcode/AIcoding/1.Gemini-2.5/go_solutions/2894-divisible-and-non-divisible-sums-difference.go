func differenceOfSums(n int, m int) int {
    sum1 := 0
    sum2 := 0

    for i := 1; i <= n; i++ {
        if i%m == 0 {
            sum2 += i
        } else {
            sum1 += i
        }
    }

    return sum1 - sum2
}