package main

func countAnagrams(s string) int {
    mod := 1000000007
    n := len(s)
    fact := make([]int, n+1)
    fact[0] = 1
    for i := 1; i <= n; i++ {
        fact[i] = fact[i-1] * i % mod
    }
    freq := make(map[rune]int)
    for _, c := range s {
        freq[c]++
    }
    res := fact[n]
    for _, v := range freq {
        res = res * pow(fact[v], mod-2, mod) % mod
    }
    return res
}

func pow(a, b, mod int) int {
    result := 1
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