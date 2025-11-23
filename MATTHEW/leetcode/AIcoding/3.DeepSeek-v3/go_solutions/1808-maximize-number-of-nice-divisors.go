func maxNiceDivisors(primeFactors int) int {
    if primeFactors == 1 {
        return 1
    }
    mod := int(1e9) + 7
    q, r := primeFactors/3, primeFactors%3
    if r == 0 {
        return pow(3, q, mod)
    } else if r == 1 {
        return pow(3, q-1, mod) * 4 % mod
    } else {
        return pow(3, q, mod) * 2 % mod
    }
}

func pow(a, b, mod int) int {
    res := 1
    for b > 0 {
        if b&1 == 1 {
            res = res * a % mod
        }
        a = a * a % mod
        b >>= 1
    }
    return res
}