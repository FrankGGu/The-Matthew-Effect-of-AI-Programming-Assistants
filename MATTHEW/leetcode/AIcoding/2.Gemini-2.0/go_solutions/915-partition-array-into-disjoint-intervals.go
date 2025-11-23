func partitionDisjoint(nums []int) int {
	leftMax := nums[0]
	overallMax := nums[0]
	partitionIndex := 0

	for i := 1; i < len(nums); i++ {
		if nums[i] < leftMax {
			partitionIndex = i
			leftMax = overallMax
		} else {
			if nums[i] > overallMax {
				overallMax = nums[i]
			}
		}
	}

	return partitionIndex + 1
}