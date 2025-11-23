func strongPasswordCheckerII(password string) bool {
	n := len(password)
	if n < 8 {
		return false
	}

	hasLower := false
	hasUpper := false
	hasDigit := false
	hasSpecial := false

	specialChars := "!@#$%^&*()-+"

	for i, r := range password {
		if unicode.IsLower(r) {
			hasLower = true
		} else if unicode.IsUpper(r) {
			hasUpper = true
		} else if unicode.IsDigit(r) {
			hasDigit = true
		} else if strings.ContainsRune(specialChars, r) {
			hasSpecial = true
		}

		if i > 0 && password[i] == password[i-1] {
			return false
		}
	}

	return hasLower && hasUpper && hasDigit && hasSpecial
}