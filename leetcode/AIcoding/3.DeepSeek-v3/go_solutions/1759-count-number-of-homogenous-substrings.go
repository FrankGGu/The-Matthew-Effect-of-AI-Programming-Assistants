func countHomogenous(s string) int {
    const mod = 1e9 + 7
    res := 0
    current := 1
    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1] {
            current++
        } else {
            res = (res + current*(current+1)/2) % mod
            current = 1
        }
    }
    res = (res + current*(current+1)/2) % mod
    return res
}