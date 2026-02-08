package main

func superPow(a int, b []int) int {
    mod := 1000000007
    result := 1
    for _, digit := range b {
        result = (pow(result, 10, mod) * pow(a, digit, mod)) % mod
    }
    return result
}

func pow(x, n, mod int) int {
    result := 1
    x = x % mod
    for n > 0 {
        if n%2 == 1 {
            result = (result * x) % mod
        }
        x = (x * x) % mod
        n = n / 2
    }
    return result
}