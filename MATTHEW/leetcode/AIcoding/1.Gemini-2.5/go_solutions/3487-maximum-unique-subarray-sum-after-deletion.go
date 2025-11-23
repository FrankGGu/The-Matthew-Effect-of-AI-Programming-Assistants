package main

func maximumUniqueSubarray(nums []int) int {
	maxSum := 0
	currentSum := 0
	left := 0
	numSet := make(map[int]bool)

	for right := 0; right < len(nums); right++ {
		for numSet[nums[right]] {
			currentSum -= nums[left]
			delete(numSet, nums[left])
			left++
		}
		currentSum += nums[right]
		numSet[nums[right]] = true
		if currentSum > maxSum {
			maxSum = currentSum
		}
	}

	return maxSum
}