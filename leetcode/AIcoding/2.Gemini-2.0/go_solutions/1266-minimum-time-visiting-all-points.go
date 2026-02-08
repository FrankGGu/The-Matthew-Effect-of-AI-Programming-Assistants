func minTimeToVisitAllPoints(points [][]int) int {
	totalTime := 0
	for i := 1; i < len(points); i++ {
		xDiff := abs(points[i][0] - points[i-1][0])
		yDiff := abs(points[i][1] - points[i-1][1])
		totalTime += max(xDiff, yDiff)
	}
	return totalTime
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}