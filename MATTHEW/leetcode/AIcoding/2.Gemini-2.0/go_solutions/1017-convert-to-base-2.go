func baseNeg2(n int) string {
	if n == 0 {
		return "0"
	}
	res := ""
	for n != 0 {
		rem := n % -2
		n /= -2
		if rem < 0 {
			rem += 2
			n++
		}
		res = string(rune('0'+rem)) + res
	}
	return res
}