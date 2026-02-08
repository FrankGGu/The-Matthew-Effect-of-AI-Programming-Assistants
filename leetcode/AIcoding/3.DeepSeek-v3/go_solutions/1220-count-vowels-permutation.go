func countVowelPermutation(n int) int {
    const mod = 1e9 + 7
    a, e, i, o, u := 1, 1, 1, 1, 1
    for k := 2; k <= n; k++ {
        newA := (e + i + u) % mod
        newE := (a + i) % mod
        newI := (e + o) % mod
        newO := i % mod
        newU := (i + o) % mod
        a, e, i, o, u = newA, newE, newI, newO, newU
    }
    return (a + e + i + o + u) % mod
}