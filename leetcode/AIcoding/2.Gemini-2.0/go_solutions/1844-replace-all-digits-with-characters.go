func replaceDigits(s string) string {
	res := []byte(s)
	for i := 1; i < len(s); i += 2 {
		res[i] = shift(res[i-1], res[i]-'0')
	}
	return string(res)
}

func shift(c byte, x byte) byte {
	return c + x
}