func countTriples(n int) int {
	count := 0
	for a := 1; a <= n; a++ {
		for b := a + 1; b <= n; b++ {
			cSquared := a*a + b*b
			c := 0
			for i := 1; i*i <= cSquared; i++ {
				if i*i == cSquared {
					c = i
					break
				}
			}
			if c > 0 && c <= n {
				count += 2
			}
		}
	}
	return count
}