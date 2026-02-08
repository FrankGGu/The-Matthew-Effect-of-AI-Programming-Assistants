func returnToBoundaryCount(nums []int) int {
	count := 0
	currentPosition := 0
	for _, step := range nums {
		currentPosition += step
		if currentPosition == 0 {
			count++
		}
	}
	return count
}