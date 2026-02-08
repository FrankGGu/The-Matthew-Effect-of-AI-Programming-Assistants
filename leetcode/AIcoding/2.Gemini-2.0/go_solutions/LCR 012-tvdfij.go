func pivotIndex(nums []int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}
	leftSum := 0
	for i, num := range nums {
		rightSum := sum - leftSum - num
		if leftSum == rightSum {
			return i
		}
		leftSum += num
	}
	return -1
}