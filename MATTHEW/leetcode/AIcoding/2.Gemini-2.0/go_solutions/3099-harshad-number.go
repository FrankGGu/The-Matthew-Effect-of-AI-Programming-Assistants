func isHarshad(n int) bool {
    sum := 0
    temp := n
    for temp > 0 {
        sum += temp % 10
        temp /= 10
    }
    if sum == 0 {
        return false
    }
    return n % sum == 0
}