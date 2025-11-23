package main

func minNonZeroProduct(a int) int {
    mod := int64(1000000007)
    if a == 1 {
        return 1
    }
    maxVal := int64((1 << a) - 1)
    count := int64((1 << (a - 1)) - 1)
    result := pow(maxVal, count, mod)
    return int((result * (maxVal - 1)) % mod)
}

func pow(base, exponent, mod int64) int64 {
    result := int64(1)
    base = base % mod
    for exponent > 0 {
        if exponent%2 == 1 {
            result = (result * base) % mod
        }
        base = (base * base) % mod
        exponent /= 2
    }
    return result
}