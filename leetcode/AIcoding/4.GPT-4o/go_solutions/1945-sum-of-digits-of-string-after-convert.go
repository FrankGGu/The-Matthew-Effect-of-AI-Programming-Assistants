func getLucky(s string, k int) int {
    sum := 0
    for _, ch := range s {
        sum += int(ch - 'a' + 1)
    }

    for k > 1 {
        newSum := 0
        for sum > 0 {
            newSum += sum % 10
            sum /= 10
        }
        sum = newSum
        k--
    }

    return sum
}