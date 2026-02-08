func minimumOneBitOperations(n int) int {
    if n == 0 {
        return 0
    }
    k := 0
    for (1 << k) <= n {
        k++
    }
    k--
    return (1 << (k + 1)) - 1 - minimumOneBitOperations(n^(1<<k))
}