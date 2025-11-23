func numberOfSequence(n int, sick []int) int {
    const mod = 1e9 + 7
    sort.Ints(sick)
    m := len(sick)
    fact := make([]int, n+1)
    invFact := make([]int, n+1)
    fact[0] = 1
    for i := 1; i <= n; i++ {
        fact[i] = fact[i-1] * i % mod
    }
    invFact[n] = pow(fact[n], mod-2, mod)
    for i := n - 1; i >= 0; i-- {
        invFact[i] = invFact[i+1] * (i + 1) % mod
    }

    res := 1
    total := n - m
    res = res * fact[total] % mod
    for i := 0; i < m; i++ {
        res = res * invFact[sick[i] - prev - 1] % mod
        prev = sick[i]
    }
    res = res * invFact[n - sick[m-1] % mod

    for i := 1; i < m; i++ {
        gap := sick[i] - sick[i-1] - 1
        if gap > 0 {
            res = res * pow(2, gap-1, mod) % mod
        }
    }
    return res
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