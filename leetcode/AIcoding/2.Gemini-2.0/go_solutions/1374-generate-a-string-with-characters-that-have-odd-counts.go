func generateTheString(n int) string {
	if n%2 == 0 {
		return string(make([]byte, n-1)) + "a" + "b"
	}
	return string(make([]byte, n)) + "a"
}