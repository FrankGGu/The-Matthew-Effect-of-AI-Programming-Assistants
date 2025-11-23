import "math"

func largestSquareArea(bottomLeft1 []int, topRight1 []int, bottomLeft2 []int, topRight2 []int) int {
	xOverlap := max(0, min(topRight1[0], topRight2[0]) - max(bottomLeft1[0], bottomLeft2[0]))
	yOverlap := max(0, min(topRight1[1], topRight2[1]) - max(bottomLeft1[1], bottomLeft2[1]))

	side := min(xOverlap, yOverlap)

	return side * side
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}