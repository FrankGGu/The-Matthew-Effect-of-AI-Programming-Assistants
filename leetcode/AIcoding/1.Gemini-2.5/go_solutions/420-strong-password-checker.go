func strongPasswordChecker(s string) int {
	n := len(s)

	hasLower := false
	hasUpper := false
	hasDigit := false

	for _, r := range s {
		if unicode.IsLower(r) {
			hasLower = true