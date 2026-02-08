func isRectangleOverlap(rec1 []int, rec2 []int) bool {
	return rec1[0] < rec2[2] && // rec1's left edge is to the left of rec2's right edge
		rec1[2] > rec2[0] && // rec1's right edge is to the right of rec2's left edge
		rec1[1] < rec2[3] && // rec1's bottom edge is below rec2's top edge
		rec1[3] > rec2[1] // rec1's top edge is above rec2's bottom edge
}