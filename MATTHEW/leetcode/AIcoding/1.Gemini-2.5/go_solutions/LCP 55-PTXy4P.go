func getMaxFruits(fruits [][]int, startPos int, k int) int {
	// Step 1: Consolidate fruits and determine max position for prefix sums.
	// Map positions to amounts.
	fruitMap := make(map[int]int)