func leastBricks(wall [][]int) int {
	widthCount := make(map[int]int)
	maxCount := 0
	for _, row := range wall {
		width := 0
		for i := 0; i < len(row)-1; i++ {
			width += row[i]
			widthCount[width]++
			if widthCount[width] > maxCount {
				maxCount = widthCount[width]
			}
		}
	}
	return len(wall) - maxCount
}