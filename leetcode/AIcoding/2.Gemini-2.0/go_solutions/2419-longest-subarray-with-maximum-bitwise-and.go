func findMax(nums []int) int {
	max := nums[0]
	for _, num := range nums {
		if num > max {
			max = num
		}
	}
	return max
}

func longestSubarray(nums []int) int {
	maxVal := findMax(nums)
	count := 0
	maxLen := 0
	for _, num := range nums {
		if num == maxVal {
			count++
			if count > maxLen {
				maxLen = count
			}
		} else {
			count = 0
		}
	}
	return maxLen
}