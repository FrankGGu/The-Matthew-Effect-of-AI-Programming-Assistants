func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func maximumScore(nums []int, k int) int {
	n := len(nums)
	left, right := k, k
	minVal := nums[k]
	maxScore := nums[k]

	for left > 0 || right < n-1 {
		if left == 0 {
			right++
			minVal = min(minVal, nums[right])
		} else if right == n-1 {
			left--
			minVal = min(minVal, nums[left])
		} else if nums[left-1] < nums[right+1] {
			right++
			minVal = min(minVal, nums[right])
		} else {
			left--
			minVal = min(minVal, nums[left])
		}
		maxScore = max(maxScore, minVal*(right-left+1))
	}

	return maxScore
}