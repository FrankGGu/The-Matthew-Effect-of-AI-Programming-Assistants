package main

func strongPasswordCheckerII(password string) bool {
    if len(password) < 8 {
        return false
    }
    hasLower := false
    hasUpper := false
    hasDigit := false
    hasSpecial := false
    for i := 0; i < len(password); i++ {
        c := password[i]
        if c >= 'a' && c <= 'z' {
            hasLower = true
        } else if c >= 'A' && c <= 'Z' {
            hasUpper = true
        } else if c >= '0' && c <= '9' {
            hasDigit = true
        } else if c == '!' || c == '@' || c == '#' || c == '$' || c == '%' || c == '^' || c == '&' || c == '*' || c == '(' || c == ')' || c == '-' || c == '+' {
            hasSpecial = true
        }
        if i > 0 && password[i] == password[i-1] {
            return false
        }
    }
    return hasLower && hasUpper && hasDigit && hasSpecial
}