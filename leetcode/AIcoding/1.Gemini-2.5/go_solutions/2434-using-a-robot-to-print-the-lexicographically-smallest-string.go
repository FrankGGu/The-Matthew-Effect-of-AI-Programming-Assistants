func robotWithString(s string) string {
	n := len(s)
	if n == 0 {
		return ""
	}

	suffixMin := make([]byte, n)
	suffixMin[n-1] = s[n-1]
	for i := n