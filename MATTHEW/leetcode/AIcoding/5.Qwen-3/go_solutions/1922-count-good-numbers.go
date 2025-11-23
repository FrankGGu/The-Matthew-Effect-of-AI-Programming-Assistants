package main

func countGoodNumbers(maxLength int) int {
    MOD := 1000000007
    return pow(25, maxLength/2, MOD) * pow(20, (maxLength+1)/2, MOD) % MOD
}

func pow(base, exponent, mod int) int {
    result := 1
    for exponent > 0 {
        if exponent%2 == 1 {
            result = result * base % mod
        }
        base = base * base % mod
        exponent /= 2
    }
    return result
}