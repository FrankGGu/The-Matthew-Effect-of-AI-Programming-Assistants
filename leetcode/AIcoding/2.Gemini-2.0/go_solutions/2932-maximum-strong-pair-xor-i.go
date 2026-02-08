func maximumStrongPairXor(nums []int) int {
	n := len(nums)
	maxVal := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if abs(nums[i]-nums[j]) <= min(nums[i], nums[j]) {
				maxVal = max(maxVal, nums[i]^nums[j])
			}
		}
	}
	return maxVal
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
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