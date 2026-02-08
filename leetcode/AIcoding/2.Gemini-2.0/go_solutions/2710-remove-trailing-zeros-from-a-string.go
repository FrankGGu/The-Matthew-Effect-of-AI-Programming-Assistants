func removeTrailingZeros(s string) string {
	n := len(s)
	for i := n - 1; i >= 0; i-- {
		if s[i] != '0' {
			return s[:i+1]
		}
	}
	return ""
}