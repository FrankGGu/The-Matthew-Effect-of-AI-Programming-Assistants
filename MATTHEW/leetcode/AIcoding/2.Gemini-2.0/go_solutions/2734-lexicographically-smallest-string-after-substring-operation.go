func smallestString(s string) string {
	n := len(s)
	start := -1
	for i := 0; i < n; i++ {
		if s[i] != 'a' {
			start = i
			break
		}
	}

	if start == -1 {
		res := []byte(s)
		res[n-1] = 'z'
		return string(res)
	}

	res := []byte(s)
	for i := start; i < n; i++ {
		if res[i] == 'a' {
			break
		}
		res[i]--
	}
	return string(res)
}