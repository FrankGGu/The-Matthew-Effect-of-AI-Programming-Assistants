func makeFancyString(s string) string {
	res := ""
	count := 0
	for i := 0; i < len(s); i++ {
		if i > 0 && s[i] == s[i-1] {
			count++
		} else {
			count = 1
		}
		if count <= 2 {
			res += string(s[i])
		}
	}
	return res
}