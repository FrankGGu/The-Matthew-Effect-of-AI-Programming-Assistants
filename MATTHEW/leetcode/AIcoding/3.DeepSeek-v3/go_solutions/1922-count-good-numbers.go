func countGoodNumbers(n int64) int {
    mod := int64(1e9 + 7)

    even := (n + 1) / 2
    odd := n / 2

    pow := func(a, b int64) int64 {
        res := int64(1)
        for b > 0 {
            if b & 1 == 1 {
                res = (res * a) % mod
            }
            a = (a * a) % mod
            b >>= 1
        }
        return res
    }

    return int((pow(5, even) * pow(4, odd)) % int(mod)
}