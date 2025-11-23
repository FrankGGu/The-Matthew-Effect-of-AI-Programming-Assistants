import "math"

func nearestValidPoint(x int, y int, points [][]int) int {
	minIndex := -1
	minDist := math.MaxInt32

	for i, point := range points {
		if point[0] == x || point[1] == y {
			dist := abs(point[0]-x) + abs(point[1]-y)
			if dist < minDist {
				minDist = dist
				minIndex = i
			}
		}
	}

	return minIndex
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}