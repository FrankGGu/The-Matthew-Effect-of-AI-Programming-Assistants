func lastSubstring(s string) string {
	i, j, k := 0, 1, 0
	n := len(s)
	for j+k < n {
		if s[i+k] == s[j+k] {
			k++
		} else if s[i+k] < s[j+k] {
			i = j
			j++
			k = 0
		} else {
			j = j + k + 1
			k = 0
		}
		if j <= i {
			j = i + 1
		}
	}
	return s[i:]
}