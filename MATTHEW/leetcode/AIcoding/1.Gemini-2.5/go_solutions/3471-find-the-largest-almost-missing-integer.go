package main

func findTheLargestAlmostMissingInteger(nums []int) int {
	if len(nums) == 0 {
		return -1
	}

	numSet := make(map[int]bool)
	maxVal := nums[0]
	minVal := nums[0]
	for _, num := range nums {
		numSet[num] = true
		if num > maxVal {
			maxVal = num
		}
		if num < minVal {
			minVal = num
		}
	}

	for i := maxVal - 1; i >= minVal-1; i-- {
		if !numSet[i] && numSet[i+1] {
			return i
		}
	}

	return -1
}