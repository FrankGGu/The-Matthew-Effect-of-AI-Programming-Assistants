func intAbs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func intMax(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func minTimeToVisitAllPoints(points [][]int) int {
	totalTime := 0

	for i := 1; i < len(points); i++ {
		prevX, prevY := points[i-1][0], points[i-1][1]
		currX, currY := points[i][0], points[i][1]

		diffX := intAbs(currX - prevX)
		diffY := intAbs(currY - prevY)

		// The time to move from (x1, y1) to (x2, y2) is max(|x2-x1|, |y2-y1|).
		// This is because diagonal moves cover both x and y distance simultaneously,
		// and horizontal/vertical moves cover only one dimension.
		// The limiting factor is the larger of the two differences.
		totalTime += intMax(diffX, diffY)
	}

	return totalTime
}