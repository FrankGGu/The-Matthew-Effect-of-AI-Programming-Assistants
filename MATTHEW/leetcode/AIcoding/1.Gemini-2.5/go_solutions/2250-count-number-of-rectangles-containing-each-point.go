type Point struct {
	x, y  int
	index int
}

func countRectangles(rectangles [][]int, points [][]int) []int {
	// Group rectangles by height. Store lengths in sorted lists for each height.