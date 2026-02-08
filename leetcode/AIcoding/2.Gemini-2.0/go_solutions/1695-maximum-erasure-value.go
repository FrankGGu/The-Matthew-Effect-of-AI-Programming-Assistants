func maximumUniqueSubarray(nums []int) int {
	maxSum := 0
	currSum := 0
	left := 0
	seen := make(map[int]bool)

	for right := 0; right < len(nums); right++ {
		for seen[nums[right]] {
			seen[nums[left]] = false
			currSum -= nums[left]
			left++
		}

		seen[nums[right]] = true
		currSum += nums[right]
		maxSum = max(maxSum, currSum)
	}

	return maxSum
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}