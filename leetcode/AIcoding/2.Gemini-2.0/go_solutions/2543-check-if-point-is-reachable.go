func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func isReachable(targetX int, targetY int) bool {
	g := gcd(targetX, targetY)
	return (g & (g - 1)) == 0
}