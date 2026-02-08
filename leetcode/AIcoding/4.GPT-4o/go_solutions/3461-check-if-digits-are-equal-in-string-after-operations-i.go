func areAlmostEqual(s1 string, s2 string) bool {
    if len(s1) != len(s2) {
        return false
    }
    count := 0
    for i := 0; i < len(s1); i++ {
        if s1[i] != s2[i] {
            count++
        }
        if count > 2 {
            return false
        }
    }
    return count == 0 || count == 2
}