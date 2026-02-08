import "math"

func minMoves(grid [][]int) int {
	type coord struct{ r, c int }

	var zeros []coord
	var extras []coord

	// Populate zeros and extras lists
	for r := 0; r < 3; r++ {
		for c := 0; c < 3