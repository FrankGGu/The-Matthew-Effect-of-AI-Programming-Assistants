func commonFactors(a int, b int) int {
    min := a
    if b < a {
        min = b
    }
    count := 0
    for i := 1; i <= min; i++ {
        if a%i == 0 && b%i == 0 {
            count++
        }
    }
    return count
}