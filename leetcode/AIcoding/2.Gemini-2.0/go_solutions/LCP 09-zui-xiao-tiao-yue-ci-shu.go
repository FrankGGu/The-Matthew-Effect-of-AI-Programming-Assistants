func jump(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	jumps := 0
	currentReach := 0
	maxReach := 0

	for i := 0; i < n-1; i++ {
		maxReach = max(maxReach, i+nums[i])

		if i == currentReach {
			jumps++
			currentReach = maxReach

			if currentReach >= n-1 {
				return jumps
			}
		}
	}

	return jumps
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}