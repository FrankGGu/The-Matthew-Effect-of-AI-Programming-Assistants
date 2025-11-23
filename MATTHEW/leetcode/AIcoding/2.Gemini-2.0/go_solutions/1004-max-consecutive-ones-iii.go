func longestOnes(nums []int, k int) int {
	left, right, zeros := 0, 0, 0
	maxLen := 0
	for right < len(nums) {
		if nums[right] == 0 {
			zeros++
		}
		for zeros > k {
			if nums[left] == 0 {
				zeros--
			}
			left++
		}
		maxLen = max(maxLen, right-left+1)
		right++
	}
	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}