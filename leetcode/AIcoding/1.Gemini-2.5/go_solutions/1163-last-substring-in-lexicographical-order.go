func lastSubstring(s string) string {
	n := len(s)
	if n == 0 {
		return ""
	}

	i, j, k := 0, 1, 0

	for j+k < n {
		if s[i+k] == s[j+k] {
			k