func countSymmetricIntegers(low int, high int) int {
    count := 0
    for num := low; num <= high; num++ {
        s := strconv.Itoa(num)
        n := len(s)
        if n % 2 != 0 {
            continue
        }
        sum1, sum2 := 0, 0
        for i := 0; i < n/2; i++ {
            sum1 += int(s[i] - '0')
            sum2 += int(s[n-1-i] - '0')
        }
        if sum1 == sum2 {
            count++
        }
    }
    return count
}