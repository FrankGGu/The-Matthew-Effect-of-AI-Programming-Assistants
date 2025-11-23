func isReachable(sx int, sy int, tx int, ty int) bool {
	gcd := func(a, b int) int {
		for b != 0 {
			a, b = b, a%b
		}
		return a
	}

	dx := tx - sx
	dy := ty - sy

	if dx < 0 || dy < 0 {
		return false
	}

	g := gcd(dx, dy)

	return g > 0 && g == gcd(dx, dy)
}