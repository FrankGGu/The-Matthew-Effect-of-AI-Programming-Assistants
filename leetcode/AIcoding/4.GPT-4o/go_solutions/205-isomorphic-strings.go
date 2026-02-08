func isIsomorphic(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }
    m1, m2 := make(map[byte]byte), make(map[byte]byte)
    for i := 0; i < len(s); i++ {
        if m1[s[i]] == 0 && m2[t[i]] == 0 {
            m1[s[i]] = t[i]
            m2[t[i]] = s[i]
        } else if m1[s[i]] != t[i] || m2[t[i]] != s[i] {
            return false
        }
    }
    return true
}