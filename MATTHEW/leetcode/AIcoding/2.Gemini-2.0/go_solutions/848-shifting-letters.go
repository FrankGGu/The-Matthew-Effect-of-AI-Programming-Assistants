func shiftingLetters(s string, shifts []int) string {
	n := len(s)
	shift := 0
	result := []byte(s)
	for i := n - 1; i >= 0; i-- {
		shift = (shift + shifts[i]) % 26
		result[i] = byte(((int(s[i]) - 'a' + shift) % 26) + 'a')
	}
	return string(result)
}