func isNumber(s string) bool {
	s = strings.TrimSpace(s)
	n := len(s)
	if n == 0 {
		return false
	}
	hasDigit := false
	hasExp := false
	hasDot := false

	for i := 0; i < n; i++ {
		c := s[i]
		if c >= '0' && c <= '9' {
			hasDigit = true
		} else if c == '+' || c == '-' {
			if i > 0 && s[i-1] != 'e' && s[i-1] != 'E' {
				return false
			}
		} else if c == '.' {
			if hasDot || hasExp {
				return false
			}
			hasDot = true
		} else if c == 'e' || c == 'E' {
			if hasExp || !hasDigit {
				return false
			}
			hasExp = true
			hasDigit = false
		} else {
			return false
		}
	}
	return hasDigit
}