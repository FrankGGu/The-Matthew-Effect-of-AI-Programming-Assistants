func modExp(base, exp, mod int) int {
    result := 1
    base = base % mod
    for exp > 0 {
        if (exp % 2) == 1 {
            result = (result * base) % mod
        }
        exp = exp >> 1
        base = (base * base) % mod
    }
    return result
}

func doubleModularExponentiation(a, b, c, d, m int) int {
    firstExp := modExp(a, b, m)
    secondExp := modExp(c, d, m)
    return (firstExp * secondExp) % m
}