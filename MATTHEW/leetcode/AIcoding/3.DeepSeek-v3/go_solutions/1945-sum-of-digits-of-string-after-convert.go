func getLucky(s string, k int) int {
    var sum int
    for _, ch := range s {
        num := int(ch - 'a' + 1)
        for num > 0 {
            sum += num % 10
            num /= 10
        }
    }
    for i := 1; i < k; i++ {
        newSum := 0
        for sum > 0 {
            newSum += sum % 10
            sum /= 10
        }
        sum = newSum
    }
    return sum
}