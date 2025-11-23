func strongPasswordCheckerII(password string) bool {
    if len(password) < 8 {
        return false
    }
    hasLower := false
    hasUpper := false
    hasDigit := false
    hasSpecial := false
    specialChars := "!@#$%^&*()-+"
    for i, c := range password {
        if i > 0 && password[i] == password[i-1] {
            return false
        }
        if c >= 'a' && c <= 'z' {
            hasLower = true
        } else if c >= 'A' && c <= 'Z' {
            hasUpper = true
        } else if c >= '0' && c <= '9' {
            hasDigit = true
        } else if strings.ContainsRune(specialChars, c) {
            hasSpecial = true
        }
    }
    return hasLower && hasUpper && hasDigit && hasSpecial
}