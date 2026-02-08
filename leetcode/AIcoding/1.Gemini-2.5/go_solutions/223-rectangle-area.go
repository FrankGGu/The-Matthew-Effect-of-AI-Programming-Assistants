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

func computeArea(ax1 int, ay1 int, ax2 int, ay2 int, bx1 int, by1 int, bx2 int, by2 int) int {
	// Calculate the area of the first rectangle
	area1 := (ax2 - ax1) * (ay2 - ay1)

	// Calculate the area of the second rectangle
	area2 := (bx2 - bx1) * (by2 - by1)

	// Calculate the coordinates of the overlapping rectangle
	// The left edge of the overlap is the maximum of the left edges of the two rectangles
	xOverlapStart := max(ax1, bx1)
	// The right edge of the overlap is the minimum of the right edges of the two rectangles
	xOverlapEnd := min(ax2, bx2)

	// The bottom edge of the overlap is the maximum of the bottom edges of the two rectangles
	yOverlapStart := max(ay1, by1)
	// The top edge of the overlap is the minimum of the top edges of the two rectangles
	yOverlapEnd := min(ay2, by2)

	// Calculate the width and height of the overlap
	// If there is no overlap, xOverlapEnd <= xOverlapStart or yOverlapEnd <= yOverlapStart,
	// so the width or height will be non-positive. We take max(0, ...) to ensure non-negative dimensions.
	overlapWidth := max(0, xOverlapEnd-xOverlapStart)
	overlapHeight := max(0, yOverlapEnd-yOverlapStart)

	// Calculate the area of the overlap
	overlapArea := overlapWidth * overlapHeight

	// The total area covered by both rectangles is the sum of their individual areas
	// minus the area of their intersection (because the intersection is counted twice).
	return area1 + area2 - overlapArea
}