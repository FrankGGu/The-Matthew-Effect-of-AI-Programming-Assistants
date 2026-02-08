import "sort"

func maxPointsInsideSquare(points [][]int, side int) int {
	n := len(points)
	maxPoints := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			x1 := points[i][0]
			y1 := points[j][1]

			count := 0
			for k := 0; k < n; k++ {
				if points[k][0] >= x1 && points[k][0] <= x1+side && points[k][1] >= y1 && points[k][1] <= y1+side {
					count++
				}
			}
			maxPoints = max(maxPoints, count)
		}
	}
	return maxPoints
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}