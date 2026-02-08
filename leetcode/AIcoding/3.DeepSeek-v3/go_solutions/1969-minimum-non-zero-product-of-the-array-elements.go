func minNonZeroProduct(p int) int {
    mod := int64(1e9 + 7)
    maxNum := (1 << p) - 1
    power := int64(maxNum - 1)
    count := int64(maxNum) / 2
    res := powMod(power, count, mod)
    res = (res * int64(maxNum)) % mod
    return int(res)
}

func powMod(x, n, mod int64) int64 {
    res := int64(1)
    for n > 0 {
        if n&1 == 1 {
            res = (res * x) % mod
        }
        x = (x * x) % mod
        n >>= 1
    }
    return res
}