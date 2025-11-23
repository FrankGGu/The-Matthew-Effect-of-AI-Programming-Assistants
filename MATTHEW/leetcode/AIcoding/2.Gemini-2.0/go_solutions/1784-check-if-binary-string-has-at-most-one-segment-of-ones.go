func checkOnesSegment(s string) bool {
	n := len(s)
	foundZero := false
	for i := 0; i < n; i++ {
		if s[i] == '0' {
			foundZero = true
		} else if foundZero && s[i] == '1' {
			return false
		}
	}
	return true
}