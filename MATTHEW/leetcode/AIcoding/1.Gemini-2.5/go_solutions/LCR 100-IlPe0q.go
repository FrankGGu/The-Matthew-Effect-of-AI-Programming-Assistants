import "math"

func minimumTotal(triangle [][]int) int {
	n := len(triangle)
	if n == 0 {
		return 0
	}

	// dp array to store minimum path sums from the current row being processed (from bottom-up)
	// to the bottom. Its size