func modifyString(s string) string {
	n := len(s)
	res := []byte(s)
	for i := 0; i < n; i++ {
		if res[i] == '?' {
			for c := 'a'; c <= 'c'; c++ {
				if (i > 0 && res[i-1] == byte(c)) || (i < n-1 && res[i+1] != '?' && res[i+1] == byte(c)) {
					continue
				}
				res[i] = byte(c)
				break
			}
		}
	}
	return string(res)
}