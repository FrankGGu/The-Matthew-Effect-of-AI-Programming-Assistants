package main

func powMod(x int, y int, mod int) int {
    result := 1
    x = x % mod
    for y > 0 {
        if y%2 == 1 {
            result = (result * x) % mod
        }
        x = (x * x) % mod
        y = y / 2
    }
    return result
}

func superPow(a int, b []int) int {
    mod := 1000000007
    exponent := 0
    for _, digit := range b {
        exponent = (exponent * 10 + digit) % (mod - 1)
    }
    return powMod(a, exponent, mod)
}