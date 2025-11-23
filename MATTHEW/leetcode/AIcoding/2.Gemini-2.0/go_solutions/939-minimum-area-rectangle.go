func minAreaRect(points [][]int) int {
	pointMap := make(map[int]map[int]bool)
	for _, p := range points {
		x, y := p[0], p[1]
		if _, ok := pointMap[x]; !ok {
			pointMap[x] = make(map[int]bool)
		}
		pointMap[x][y] = true
	}

	minArea := 0
	for i := 0; i < len(points); i++ {
		for j := i + 1; j < len(points); j++ {
			x1, y1 := points[i][0], points[i][1]
			x2, y2 := points[j][0], points[j][1]

			if x1 == x2 || y1 == y2 {
				continue
			}

			if pointMap[x1][y2] && pointMap[x2][y1] {
				area := abs(x1-x2) * abs(y1-y2)
				if minArea == 0 || area < minArea {
					minArea = area
				}
			}
		}
	}

	return minArea
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}