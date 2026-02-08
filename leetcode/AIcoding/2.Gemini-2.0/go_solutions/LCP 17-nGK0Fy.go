func calculate(s string) int {
	x, y := 1, 0
	for _, r := range s {
		if r == 'A' {
			x = 2*x + y
		} else if r == 'B' {
			y = 2*y + x
		}
	}
	return x + y
}