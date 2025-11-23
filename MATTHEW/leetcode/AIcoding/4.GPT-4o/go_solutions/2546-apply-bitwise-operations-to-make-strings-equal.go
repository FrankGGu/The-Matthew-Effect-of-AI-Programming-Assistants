func makeStringsEqual(s1 string, s2 string) bool {
    if len(s1) != len(s2) {
        return false
    }
    hasA1 := false
    hasA2 := false
    for i := 0; i < len(s1); i++ {
        if s1[i] == 'a' {
            hasA1 = true
        }
        if s2[i] == 'a' {
            hasA2 = true
        }
    }
    return hasA1 == hasA2
}