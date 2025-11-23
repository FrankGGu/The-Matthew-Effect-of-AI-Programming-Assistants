func minimumSwap(s1 string, s2 string) int {
	x_y, y_x := 0, 0
	for i := 0; i < len(s1); i++ {
		if s1[i] == 'x' && s2[i] == 'y' {
			x_y++
		} else if s1[i] == 'y' && s2[i] == 'x' {
			y_x++
		}
	}

	if (x_y+y_x)%2 != 0 {
		return -1
	}

	return x_y/2 + y_x/2 + x_y%2 + y_x%2
}