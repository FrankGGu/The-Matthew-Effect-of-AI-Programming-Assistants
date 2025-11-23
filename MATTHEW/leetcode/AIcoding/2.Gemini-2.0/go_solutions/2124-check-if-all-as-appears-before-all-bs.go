func checkString(s string) bool {
    bFound := false
    for _, char := range s {
        if char == 'b' {
            bFound = true
        } else if bFound && char == 'a' {
            return false
        }
    }
    return true
}