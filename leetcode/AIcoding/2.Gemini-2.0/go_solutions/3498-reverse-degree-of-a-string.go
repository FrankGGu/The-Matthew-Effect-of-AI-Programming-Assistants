func reverseDegree(s string) string {
	n := len(s)
	if n == 0 {
		return ""
	}

	runes := []rune(s)
	for i := 0; i < n/2; i++ {
		runes[i], runes[n-1-i] = runes[n-1-i], runes[i]
	}
	return string(runes)
}