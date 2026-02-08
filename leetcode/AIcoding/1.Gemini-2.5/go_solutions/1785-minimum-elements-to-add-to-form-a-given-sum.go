package main

func minElements(nums []int, limit int, goal int) int {
	var currentSum int64
	for _, num := range nums {
		currentSum += int64(num)
	}

	diff := int64(goal) - currentSum

	if diff == 0 {
		return 0
	}

	var absDiff int64
	if diff < 0 {
		absDiff = -diff
	} else {
		absDiff = diff
	}

	limit64 := int64(limit)

	// Calculate ceil(absDiff / limit64) using integer division
	result := (absDiff + limit64 - 1) / limit64

	return int(result)
}