func sumOfGoodNumbers(n int64) int64 {
    mod := int64(1e9 + 7)
    if n%2 == 0 {
        return (modPow(5, n/2, mod) + modPow(4, n/2, mod)) % mod
    }
    return (modPow(5, n/2, mod) * 5 % mod + modPow(4, n/2, mod)) % mod
}

func modPow(base, exp, mod int64) int64 {
    result := int64(1)
    base = base % mod
    for exp > 0 {
        if exp%2 == 1 {
            result = (result * base) % mod
        }
        exp = exp >> 1
        base = (base * base) % mod
    }
    return result
}