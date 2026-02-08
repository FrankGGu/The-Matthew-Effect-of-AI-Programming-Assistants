func minimumOneBitOperations(n int) int {
    res := 0
    for n > 0 {
        res ^= n
        n >>= 1
    }
    return res
}