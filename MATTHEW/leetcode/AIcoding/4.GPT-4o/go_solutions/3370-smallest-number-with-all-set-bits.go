func smallestNumberWithAllSetBits(n int) int {
    if n == 0 {
        return 0
    }
    result := 0
    for i := 0; i < n; i++ {
        result |= (1 << i)
    }
    return result
}