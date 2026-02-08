func stringCount(n int) int {
    mod := 1000000007
    total := power(26, n, mod)
    noL := power(25, n, mod)
    noO := power(25, n, mod)
    noV := power(25, n, mod)
    noLO := power(24, n, mod)
    noLV := power(24, n, mod)
    noOV := power(24, n, mod)
    noLOV := power(23, n, mod)

    result := (total - noL - noO - noV + noLO + noLV + noOV - noLOV) % mod

    if result < 0 {
        result += mod
    }

    return result
}

func power(base, exp, mod int) int {
    res := 1
    base %= mod
    for exp > 0 {
        if exp%2 == 1 {
            res = (res * base) % mod
        }
        base = (base * base) % mod
        exp /= 2
    }
    return res
}