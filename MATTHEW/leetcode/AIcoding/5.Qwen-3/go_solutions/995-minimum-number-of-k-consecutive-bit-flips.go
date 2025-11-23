package main

func minKBitFlips(nums []int, k int) int {
	n := len(nums)
	flip := make([]int, n+1)
	result := 0
	currentFlip := 0

	for i := 0; i < n; i++ {
		currentFlip += flip[i]
		if nums[i] == 0 && currentFlip%2 == 0 {
			result++
			currentFlip++
			if i+k < n {
				flip[i+k]--
			}
		} else if nums[i] == 1 && currentFlip%2 == 1 {
			result++
			currentFlip++
			if i+k < n {
				flip[i+k]--
			}
		}
	}

	return result
}