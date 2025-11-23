package main

func minOperationsToMakeStringSorted(s string) int {
    mod := int64(1000000007)
    n := len(s)
    fact := make([]int64, n+1)
    invFact := make([]int64, n+1)
    fact[0] = 1
    for i := 1; i <= n; i++ {
        fact[i] = fact[i-1] * int64(i) % mod
    }
    invFact[n] = pow(fact[n], mod-2, mod)
    for i := n - 1; i >= 0; i-- {
        invFact[i] = invFact[i+1] * int64(i+1) % mod
    }

    count := make([]int, 26)
    for _, c := range s {
        count[int(c-'a')]++
    }

    res := int64(0)
    for i := 0; i < n; i++ {
        c := int(s[i] - 'a')
        for j := 0; j < c; j++ {
            if count[j] == 0 {
                continue
            }
            temp := count[j]
            count[j]--
            numerator := fact[n-i-1]
            denominator := 1
            for k := 0; k < 26; k++ {
                denominator = denominator * invFact[count[k]] % mod
            }
            res = (res + numerator * denominator) % mod
            count[j]++
        }
        count[c]--
    }
    return int(res)
}

func pow(a, b, mod int64) int64 {
    result := int64(1)
    a = a % mod
    for b > 0 {
        if b%2 == 1 {
            result = result * a % mod
        }
        a = a * a % mod
        b /= 2
    }
    return result
}