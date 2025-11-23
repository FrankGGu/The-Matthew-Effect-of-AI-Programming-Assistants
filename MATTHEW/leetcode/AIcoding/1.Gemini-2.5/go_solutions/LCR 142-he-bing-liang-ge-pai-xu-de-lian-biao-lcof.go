func maxTrainingSessions(nums []int, k int) int {
	n := len(nums)
	maxSum := 0
	currentSum := 0
	left := 0

	for right := 0; right < n; right++ {
		if nums[right] == 0 {
			currentSum = 0
			left = right + 1
		} else {
			currentSum += nums[right]
			for currentSum >= k {
				if currentSum > maxSum {
					maxSum = currentSum
				}
				currentSum -= nums[left]
				left++
			}
		}
	}

	return maxSum
}