func isScramble(s1 string, s2 string) bool {
    n := len(s1)
    if n != len(s2) {
        return false
    }
    if s1 == s2 {
        return true
    }
    count := make([]int, 256)
    for i := 0; i < n; i++ {
        count[s1[i]]++
        count[s2[i]]--
    }
    for i := 0; i < 256; i++ {
        if count[i] != 0 {
            return false
        }
    }
    for i := 1; i < n; i++ {
        if (isScramble(s1[:i], s2[:i]) && isScramble(s1[i:], s2[i:]) {
            return true
        }
        if (isScramble(s1[:i], s2[n-i:]) && isScramble(s1[i:], s2[:n-i])) {
            return true
        }
    }
    return false
}