func robot(s string) int {
	x := 0
	for _, char := range s {
		if char == 'A' {
			x++
		} else if char == 'B' {
			x *= 2
		}
	}
	return x
}