func findLengthOfLCIS(nums []int) int {
	if len(nums) == 0 {
		return 0
	}
	maxLen := 1
	currLen := 1
	for i := 1; i < len(nums); i++ {
		if nums[i] > nums[i-1] {
			currLen++
			if currLen > maxLen {
				maxLen = currLen
			}
		} else {
			currLen = 1
		}
	}
	return maxLen
}