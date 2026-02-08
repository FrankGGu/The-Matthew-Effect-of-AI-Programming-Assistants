import (
	"math"
)

func minAreaRect(points [][]int) int {
	n := len(points)
	if n < 4 {
		return 0
	}

	pointMap := make(map[int]map[int]bool)
	for _, p := range points {
		x, y := p[0], p[1]
		if _, ok := pointMap[x]; !ok {
			pointMap[x] = make(map[int]bool)
		}
		pointMap[x][y] = true
	}

	minArea := math.MaxInt32

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			x1, y1 := points[i][0], points[i][1]
			x2, y2 := points[j][0], points[j][1]

			if x1 == x2 || y1 == y2 {
				continue
			}

			if pointMap[x1][y2] && pointMap[x2][y1] {
				area := abs(x1-x2) * abs(y1-y2)
				if area < minArea {
					minArea = area
				}
			}
		}
	}

	if minArea == math.MaxInt32 {
		return 0
	}

	return minArea
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}