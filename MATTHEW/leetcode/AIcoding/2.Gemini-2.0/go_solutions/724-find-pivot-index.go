func pivotIndex(nums []int) int {
	total := 0
	for _, num := range nums {
		total += num
	}
	leftSum := 0
	for i, num := range nums {
		rightSum := total - leftSum - num
		if leftSum == rightSum {
			return i
		}
		leftSum += num
	}
	return -1
}