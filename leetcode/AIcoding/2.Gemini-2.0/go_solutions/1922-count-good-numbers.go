func countGoodNumbers(n int64) int {
    mod := int64(1000000007)
    even := (n + 1) / 2
    odd := n / 2

    pow5 := power(5, even, mod)
    pow4 := power(4, odd, mod)

    return int((pow5 * pow4) % mod)
}

func power(base, exp, mod int64) int64 {
    res := int64(1)
    base %= mod
    for exp > 0 {
        if exp % 2 == 1 {
            res = (res * base) % mod
        }
        base = (base * base) % mod
        exp /= 2
    }
    return res
}