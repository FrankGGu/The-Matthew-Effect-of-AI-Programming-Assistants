package main

func longestSubarray(nums []int) int {
	maxAnd := 0
	for _, num := range nums {
		maxAnd |= num
	}

	maxLength := 0
	currentLength := 0

	for _, num := range nums {
		if num == maxAnd {
			currentLength++
			if currentLength > maxLength {
				maxLength = currentLength
			}
		} else {
			currentLength = 0
		}
	}

	return maxLength
}