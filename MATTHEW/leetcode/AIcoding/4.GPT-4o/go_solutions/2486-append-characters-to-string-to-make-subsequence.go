func appendCharacters(s string, t string) int {
    m, n := len(s), len(t)
    j := 0
    for i := 0; i < m && j < n; i++ {
        if s[i] == t[j] {
            j++
        }
    }
    return n - j
}