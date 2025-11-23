func minMaxGame(nums []int) int {
	n := len(nums)
	for n > 1 {
		newNums := make([]int, n/2)
		for i := 0; i < n/2; i++ {
			if i%2 == 0 {
				newNums[i] = min(nums[2*i], nums[2*i+1])
			} else {
				newNums[i] = max(nums[2*i], nums[2*i+1])
			}
		}
		nums = newNums
		n = len(nums)
	}
	return nums[0]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}