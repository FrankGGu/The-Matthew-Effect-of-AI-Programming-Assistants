func isHarshad(n int) bool {
    sum := 0
    temp := n
    for temp > 0 {
        sum += temp % 10
        temp /= 10
    }
    return n % sum == 0
}