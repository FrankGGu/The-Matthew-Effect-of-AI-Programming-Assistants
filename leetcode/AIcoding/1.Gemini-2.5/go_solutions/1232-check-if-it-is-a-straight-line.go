func checkStraightLine(coordinates [][]int) bool {
	if len(coordinates) <= 2 {
		return true
	}

	x0, y0 := coordinates[0][0], coordinates[0][1]
	x1, y1 := coordinates[1][0], coordinates[1][1]

	deltaY := y1 - y0
	deltaX := x1 - x0

	for i := 2; i < len(coordinates); i++ {
		xi, yi := coordinates[i][0], coordinates[i][1]
		if (yi-y0)*deltaX != (xi-x0)*deltaY {
			return false
		}
	}

	return true
}