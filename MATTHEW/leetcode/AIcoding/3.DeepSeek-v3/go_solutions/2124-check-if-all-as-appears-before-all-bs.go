func checkString(s string) bool {
    foundB := false
    for _, ch := range s {
        if ch == 'b' {
            foundB = true
        } else if foundB && ch == 'a' {
            return false
        }
    }
    return true
}