func mirrorReflection(p int, q int) int {
	g := gcd(p, q)
	p /= g
	q /= g
	if p%2 == 0 && q%2 == 1 {
		return 2
	}
	if p%2 == 1 && q%2 == 1 {
		return 1
	}
	return 0
}

func gcd(a int, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}