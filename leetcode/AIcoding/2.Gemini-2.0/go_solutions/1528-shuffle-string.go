func restoreString(s string, indices []int) string {
	res := make([]byte, len(s))
	for i := 0; i < len(s); i++ {
		res[indices[i]] = s[i]
	}
	return string(res)
}