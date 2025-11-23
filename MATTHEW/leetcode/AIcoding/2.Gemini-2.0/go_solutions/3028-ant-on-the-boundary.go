func returnToBoundaryCount(nums []int) int {
	count := 0
	sum := 0
	for _, num := range nums {
		sum += num
		if sum == 0 {
			count++
		}
	}
	return count
}