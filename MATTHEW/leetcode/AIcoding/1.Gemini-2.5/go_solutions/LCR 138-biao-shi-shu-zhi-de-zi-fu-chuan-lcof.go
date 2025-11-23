package main

import (
	"strings"
)

func isNumber(s string) bool {
	s = strings.TrimSpace(s)
	if len(s) == 0 {
		return false
	}

	hasDigit := false
	hasDot := false
	hasE := false

	i := 0
	if s[i] == '+' || s[i] == '-' {
		i++
	}

	for i < len(s) {
		char := s[i]
		if char >= '0' && char <= '9' {
			hasDigit = true
		} else if char == '.' {
			if hasDot || hasE {
				return false
			}
			hasDot = true
		} else if char == 'e' || char == 'E' {
			if hasE || !hasDigit {
				return false
			}
			hasE = true
			hasDigit = false
		} else if char == '+' || char == '-' {
			if s[i-1] != 'e' && s[i-1] != 'E' {
				return false
			}
		} else {
			return false
		}
		i++
	}

	return hasDigit
}