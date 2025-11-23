func interchangeableRectangles(rectangles [][]int) int64 {
	count := int64(0)
	ratioMap := make(map[float64]int)

	for _, rect := range rectangles {
		width := float64(rect[0])
		height := float64(rect[1])
		ratio := width / height
		count += int64(ratioMap[ratio])
		ratioMap[ratio]++
	}

	return count
}