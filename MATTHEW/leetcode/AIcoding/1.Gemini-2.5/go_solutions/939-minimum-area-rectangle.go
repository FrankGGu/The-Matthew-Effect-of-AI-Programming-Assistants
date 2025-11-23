func minAreaRect(points [][]int) int {
	// Use a map to store points for O(1) lookup
	// The structure is map[x_coord]map[y_coord]bool
	pointSet := make(map[int]map[int]bool)
	for _, p