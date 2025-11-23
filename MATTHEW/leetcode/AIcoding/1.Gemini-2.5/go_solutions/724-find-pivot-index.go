func pivotIndex(nums []int) int {
	totalSum := 0
	for _, num := range nums {
		totalSum += num
	}

	leftSum := 0
	for i, num := range nums {
		// The sum of elements to the right of index i is totalSum - leftSum - nums[i].
		// leftSum is the sum of elements strictly to the left of index i.
		rightSum := totalSum - leftSum - num
		if leftSum == rightSum {
			return i
		}
		// Add the current element to leftSum for the next iteration.
		// In the next iteration, nums[i] will be part of the left sum for index i+1.
		leftSum += num
	}

	return -1
}