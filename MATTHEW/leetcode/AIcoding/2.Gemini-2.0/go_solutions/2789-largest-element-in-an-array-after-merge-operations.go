func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func largestElement(nums []int) int {
	n := len(nums)
	for i := n - 2; i >= 0; i-- {
		if nums[i] <= nums[i+1] {
			nums[i] += nums[i+1]
		}
	}
	return nums[0]
}