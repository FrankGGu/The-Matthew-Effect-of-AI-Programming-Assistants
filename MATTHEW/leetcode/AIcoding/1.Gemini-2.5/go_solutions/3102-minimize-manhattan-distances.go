func minimizeManhattanDistance(points [][]int) int {
	n := len(points)

	// Transform coordinates and store original indices
	type TransformedPoint struct {
		u   int
		v   int
		idx int
	}

	transformed := make([]