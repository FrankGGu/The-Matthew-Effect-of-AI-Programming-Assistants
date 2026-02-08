func sumOfSubseqWidths(A []int) int {
    sort.Ints(A)
    n := len(A)
    mod := 1_000_000_007
    result := 0
    pow2 := 1

    for i := 0; i < n; i++ {
        result = (result + (A[i]*pow2) % mod) % mod
        pow2 = (pow2 * 2) % mod
    }

    pow2 = 1
    for i := n - 1; i >= 0; i-- {
        result = (result - (A[i]*pow2) % mod + mod) % mod
        pow2 = (pow2 * 2) % mod
    }

    return result
}