func isRectangleCornerReachable(width int, height int, k int) bool {
	gcd := func(a, b int) int {
		for b != 0 {
			a, b = b, a%b
		}
		return a
	}

	return gcd(width, height) == 1
}