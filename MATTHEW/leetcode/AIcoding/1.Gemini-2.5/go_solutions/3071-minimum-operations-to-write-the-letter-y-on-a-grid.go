import "math"

func minimumOperations(grid [][]int) int {
	n := len(grid)

	yCounts := [3]int{}      // Counts for colors 0, 1, 2 within Y shape
	nonYCounts := [3]int{} // Counts for colors 0, 1, 2