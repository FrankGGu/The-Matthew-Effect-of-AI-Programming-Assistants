func modifyString(s string) string {
	n := len(s)
	str := []byte(s)
	for i := 0; i < n; i++ {
		if str[i] == '?' {
			for j := byte('a'); j <= byte('c'); j++ {
				if (i > 0 && str[i-1] == j) || (i < n-1 && str[i+1] != '?' && str[i+1] == j) {
					continue
				}
				str[i] = j
				break
			}
		}
	}
	return string(str)
}