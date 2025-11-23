func isSubsequence(s string, t string) bool {
	i := 0
	j := 0

	for i < len(s) && j < len(t) {
		if s[i] == t[j] {
			j++
		}
		i++
	}

	return j == len(t)
}