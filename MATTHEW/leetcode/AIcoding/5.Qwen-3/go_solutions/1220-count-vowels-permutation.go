package main

func countVowelPermutation(n int) int {
    mod := 1000000007
    a, e, i, o, u := 1, 1, 1, 1, 1
    for j := 2; j <= n; j++ {
        a, e, i, o, u = (e + i + u) % mod, (a + i) % mod, (e + o) % mod, (i) % mod, (i + o) % mod
    }
    return (a + e + i + o + u) % mod
}