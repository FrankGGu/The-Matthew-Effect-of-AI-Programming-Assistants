import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxSumSlices(slices []int, k int) int {