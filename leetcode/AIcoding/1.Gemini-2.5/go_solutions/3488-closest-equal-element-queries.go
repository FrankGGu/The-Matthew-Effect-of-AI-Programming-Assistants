func closestEqual(nums []int, queries [][]int) []int {
	// Pre-process nums to store indices for each value.
	// The slices of indices will automatically be sorted because we iterate through nums from left to right.
	indicesMap := make(