import "container/list"

func largestRectangleArea(heights []int) int {
	n := len(heights)
	if n == 0 {
		return 0
	}

	// Add sentinels (0 height bars) at the beginning and end
	// to simplify boundary conditions for width calculation.
	// This