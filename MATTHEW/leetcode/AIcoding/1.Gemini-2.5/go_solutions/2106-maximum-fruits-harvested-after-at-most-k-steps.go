func getMaxFruits(fruits [][]int, startPos int, k int) int {
	maxCoord := 200000 // Maximum possible coordinate as per constraints
	// Find the maximum position mentioned in fruits or reachable by k steps
	// This helps to size the prefix sum array efficiently, though 200001 is a safe upper