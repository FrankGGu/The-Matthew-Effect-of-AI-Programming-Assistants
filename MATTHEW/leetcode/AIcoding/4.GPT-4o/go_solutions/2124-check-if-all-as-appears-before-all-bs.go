func checkString(s string) bool {
    foundB := false
    for _, char := range s {
        if char == 'b' {
            foundB = true
        } else if foundB && char == 'a' {
            return false
        }
    }
    return true
}