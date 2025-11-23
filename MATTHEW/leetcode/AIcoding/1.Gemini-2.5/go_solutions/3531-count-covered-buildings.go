func countCoveredBuildings(buildings [][]int) int {
	// Sort buildings:
	// 1. By x_start in ascending order.
	// 2. If x_start are equal, by x_end in descending order (to prioritize larger X intervals).
	//