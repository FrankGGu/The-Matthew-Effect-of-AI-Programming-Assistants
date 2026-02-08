func commonFactors(a int, b int) int {
    count := 0
    limit := a
    if b < a {
        limit = b
    }

    for i := 1; i <= limit; i++ {
        if a%i == 0 && b%i == 0 {
            count++
        }
    }
    return count
}