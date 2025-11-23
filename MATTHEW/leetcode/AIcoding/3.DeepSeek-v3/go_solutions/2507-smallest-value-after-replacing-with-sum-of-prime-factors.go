func smallestValue(n int) int {
    for {
        sum, num := 0, n
        for i := 2; i <= num; i++ {
            for num%i == 0 {
                sum += i
                num /= i
            }
        }
        if sum == n {
            break
        }
        n = sum
    }
    return n
}