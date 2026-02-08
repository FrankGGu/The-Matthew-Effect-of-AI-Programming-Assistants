func stringCount(n int) int {
    mod := int(1e9 + 7)
    total := pow(26, n, mod)
    noL := pow(25, n, mod)
    noT := noL
    noE := pow(25, n, mod)
    noLnoT := pow(24, n, mod)
    noLnoE := noLnoT
    noTnoE := noLnoT
    noLnoTnoE := pow(23, n, mod)

    res := (total - noL - noT - noE + noLnoT + noLnoE + noTnoE - noLnoTnoE) % mod
    if res < 0 {
        res += mod
    }
    return res
}

func pow(a, b, mod int) int {
    res := 1
    for b > 0 {
        if b & 1 == 1 {
            res = (res * a) % mod
        }
        a = (a * a) % mod
        b >>= 1
    }
    return res
}