func addMinimum(a int) int {
    sum := 0
    for a > 0 {
        sum += a % 10
        a /= 10
    }
    if sum%10 == 0 {
        return 0
    }
    return 10 - sum%10
}