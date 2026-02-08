func strongPasswordCheckerII(password string) bool {
    if len(password) < 8 {
        return false
    }

    hasLowercase := false
    hasUppercase := false
    hasDigit := false
    hasSpecial := false
    hasAdjacent := false

    specialChars := "!@#$%^&*()-+"

    for i, char := range password {
        if 'a' <= char && char <= 'z' {
            hasLowercase = true
        } else if 'A' <= char && char <= 'Z' {
            hasUppercase = true
        } else if '0' <= char && char <= '9' {
            hasDigit = true
        } else {
            for _, specialChar := range specialChars {
                if char == specialChar {
                    hasSpecial = true
                    break
                }
            }
        }

        if i > 0 && password[i] == password[i-1] {
            hasAdjacent = true
        }
    }

    return hasLowercase && hasUppercase && hasDigit && hasSpecial && !hasAdjacent
}