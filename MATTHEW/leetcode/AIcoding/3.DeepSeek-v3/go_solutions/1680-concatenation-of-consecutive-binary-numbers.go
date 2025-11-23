func concatenatedBinary(n int) int {
    const mod = 1e9 + 7
    res := 0
    shift := 0
    for i := 1; i <= n; i++ {
        if (i & (i - 1)) == 0 {
            shift++
        }
        res = ((res << shift) + i) % mod
    }
    return res
}