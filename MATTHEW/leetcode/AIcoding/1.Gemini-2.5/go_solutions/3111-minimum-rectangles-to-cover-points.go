func minRectanglesToCoverPoints(points [][]int, w int) int {
	if len(points) == 0 {
		return 0
	}

	xCoords := make([]int, len(points))
	for i, p := range points {
		xCoords[