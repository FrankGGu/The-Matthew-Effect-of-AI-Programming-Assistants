func minNonZeroProduct(n int) int {
    const mod = 1_000_000_007
    if n == 1 {
        return 1
    }
    maxNum := (1 << n) - 1
    maxNumMinusOne := maxNum - 1
    exponent := (maxNumMinusOne / 2) % (mod - 1)
    base := maxNum % mod
    result := pow(base, exponent, mod)
    result = (result * (maxNum % mod)) % mod
    return result
}

func pow(base, exp, mod int) int {
    res := 1
    base = base % mod
    for exp > 0 {
        if exp%2 == 1 {
            res = (res * base) % mod
        }
        base = (base * base) % mod
        exp /= 2
    }
    return res
}