func maxChunksToSorted(arr []int) int {
	maxVal := 0
	count := 0
	for i, num := range arr {
		if num > maxVal {
			maxVal = num
		}
		if maxVal == i {
			count++
		}
	}
	return count
}