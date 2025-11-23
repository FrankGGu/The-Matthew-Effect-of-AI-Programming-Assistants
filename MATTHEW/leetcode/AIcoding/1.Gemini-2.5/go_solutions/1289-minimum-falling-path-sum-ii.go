import "math"

func minFallingPathSum(grid [][]int) int {
	n := len(grid)
	if n == 0 {
		return 0
	}

	// dp represents the minimum falling path sum to reach each cell in the current row.
	// We only need to store the values for the previous row to calculate