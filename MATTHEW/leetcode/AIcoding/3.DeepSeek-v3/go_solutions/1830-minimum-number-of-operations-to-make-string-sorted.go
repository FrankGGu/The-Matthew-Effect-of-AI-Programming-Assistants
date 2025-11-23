func makeStringSorted(s string) int {
    const mod = 1e9 + 7
    n := len(s)
    fact := make([]int, n+1)
    inv := make([]int, n+1)
    fact[0], inv[0] = 1, 1
    for i := 1; i <= n; i++ {
        fact[i] = (fact[i-1] * i) % mod
        inv[i] = powMod(fact[i], mod-2, mod)
    }

    res := 0
    freq := [26]int{}
    for i := n - 1; i >= 0; i-- {
        c := int(s[i] - 'a')
        freq[c]++
        current := 0
        for j := 0; j < c; j++ {
            if freq[j] == 0 {
                continue
            }
            temp := fact[n - i - 1]
            for k := 0; k < 26; k++ {
                if freq[k] == 0 {
                    continue
                }
                temp = (temp * inv[freq[k]]) % mod
            }
            if k := freq[j]; k > 0 {
                temp = (temp * fact[k]) % mod
                temp = (temp * inv[k-1]) % mod
            }
            current = (current + temp) % mod
        }
        res = (res + current) % mod
    }
    return res
}

func powMod(a, b, mod int) int {
    res := 1
    for b > 0 {
        if b&1 == 1 {
            res = (res * a) % mod
        }
        a = (a * a) % mod
        b >>= 1
    }
    return res
}