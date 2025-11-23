func maxArea(points [][]int, maxX int, maxY int) int {
	if len(points) == 0 {
		return 0
	}

	return maxX * maxY
}