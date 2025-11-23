func minNonZeroProduct(p int) int {
    mod := int(1e9 + 7)
    max := (1 << p) - 1
    count := (max >> 1)
    result := pow(max-1, count, mod)
    result = (result * max) % mod
    return result
}

func pow(base, exp, mod int) int {
    result := 1
    for exp > 0 {
        if exp % 2 == 1 {
            result = (result * base) % mod
        }
        base = (base * base) % mod
        exp /= 2
    }
    return result
}