func checkOnesSegment(s string) bool {
    hasZero := false
    for i := 1; i < len(s); i++ {
        if s[i] == '0' {
            hasZero = true
        } else if hasZero {
            return false
        }
    }
    return true
}