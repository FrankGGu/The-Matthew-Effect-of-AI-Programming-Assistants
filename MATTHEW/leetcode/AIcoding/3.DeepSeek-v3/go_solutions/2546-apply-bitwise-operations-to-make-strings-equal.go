func makeStringsEqual(s string, target string) bool {
    hasOneS := false
    hasOneTarget := false
    for i := 0; i < len(s); i++ {
        if s[i] == '1' {
            hasOneS = true
            break
        }
    }
    for i := 0; i < len(target); i++ {
        if target[i] == '1' {
            hasOneTarget = true
            break
        }
    }
    return hasOneS == hasOneTarget
}