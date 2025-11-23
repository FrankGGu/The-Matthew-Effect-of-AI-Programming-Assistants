func numberOfWays(startPos int, endPos int, k int) int {
    const mod = 1000000007
    diff := abs(endPos - startPos)
    if diff > k || (k-diff)%2 != 0 {
        return 0
    }

    steps := (k + diff) / 2
    return comb(k, steps, mod)
}

func comb(n, k int, mod int) int {
    if k > n {
        return 0
    }
    if k == 0 || k == n {
        return 1
    }

    num := 1
    denom := 1
    for i := 0; i < k; i++ {
        num = (num * (n - i)) % mod
        denom = (denom * (i + 1)) % mod
    }
    return (num * modInverse(denom, mod)) % mod
}

func modInverse(a, mod int) int {
    return pow(a, mod-2, mod)
}

func pow(x, y, mod int) int {
    res := 1
    x = x % mod
    for y > 0 {
        if y&1 == 1 {
            res = (res * x) % mod
        }
        y = y >> 1
        x = (x * x) % mod
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}