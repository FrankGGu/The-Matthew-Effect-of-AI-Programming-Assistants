func superPow(a int, b []int) int {
    mod := 1337
    res := 1
    a = a % mod

    for i := len(b) - 1; i >= 0; i-- {
        res = (res * pow(a, b[i], mod)) % mod
        a = pow(a, 10, mod)
    }

    return res
}

func pow(x, n, mod int) int {
    result := 1
    x = x % mod
    for n > 0 {
        if n%2 == 1 {
            result = (result * x) % mod
        }
        x = (x * x) % mod
        n /= 2
    }
    return result
}