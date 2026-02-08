func findMaxValueOfEquation(points [][]int, k int) int {
	maxVal := math.MinInt32
	// deque stores indices of points
	// The front of the deque will always have the maximum (yi - xi)
	// for points