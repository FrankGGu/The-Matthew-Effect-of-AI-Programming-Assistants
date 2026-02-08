func isNumber(s string) bool {
	n := len(s)
	i := 0

	// Skip leading spaces
	for i < n && s[i] == ' ' {
		i++
	}

	// Check for sign
	if i < n && (s[i] == '+' || s[i] == '-') {
		i++
	}

	// Check for digits before dot
	hasDigits := false
	for i < n && s[i] >= '0' && s[i] <= '9' {
		hasDigits = true
		i++
	}

	// Check for dot
	if i < n && s[i] == '.' {
		i++
		// Check for digits after dot
		for i < n && s[i] >= '0' && s[i] <= '9' {
			hasDigits = true
			i++
		}
		// If no digits before or after dot, it's invalid
		if !hasDigits {
			return false
		}
	} else if !hasDigits {
		return false
	}

	// Check for exponent
	if i < n && (s[i] == 'e' || s[i] == 'E') {
		i++
		// Check for sign after exponent
		if i < n && (s[i] == '+' || s[i] == '-') {
			i++
		}
		// Check for digits after exponent
		hasExponentDigits := false
		for i < n && s[i] >= '0' && s[i] <= '9' {
			hasExponentDigits = true
			i++
		}
		// If no digits after exponent, it's invalid
		if !hasExponentDigits {
			return false
		}
	}

	// Skip trailing spaces
	for i < n && s[i] == ' ' {
		i++
	}

	// If we reached the end of the string, it's valid
	return i == n
}