package main

func minMaxGame(nums []int) int {
	for len(nums) > 1 {
		newNums := make([]int, 0, len(nums)/2)
		for i := 0; i < len(nums); i += 2 {
			minVal := nums[i]
			if i+1 < len(nums) {
				minVal = min(minVal, nums[i+1])
			}
			newNums = append(newNums, minVal)
		}
		nums = newNums
	}
	return nums[0]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}