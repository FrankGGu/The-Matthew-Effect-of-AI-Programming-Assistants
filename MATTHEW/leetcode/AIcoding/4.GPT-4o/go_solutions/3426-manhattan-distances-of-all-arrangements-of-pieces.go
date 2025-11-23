func manhattanDistanceSum(A []int) int {
    n := len(A)
    mod := int(1e9 + 7)

    xSum, ySum := 0, 0
    for _, a := range A {
        xSum = (xSum + a) % mod
        ySum = (ySum + a) % mod
    }

    result := 0
    for _, a := range A {
        result = (result + (a * (n-1) % mod * (xSum - a + mod) % mod) % mod) % mod
        result = (result + (a * (n-1) % mod * (ySum - a + mod) % mod) % mod) % mod
    }

    return result * pow(n, mod-2, mod) % mod
}

func pow(x, y, p int) int {
    res := 1
    x = x % p
    for y > 0 {
        if y&1 == 1 {
            res = (res * x) % p
        }
        y = y >> 1
        x = (x * x) % p
    }
    return res
}