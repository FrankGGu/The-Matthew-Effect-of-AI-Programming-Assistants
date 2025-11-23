func minOperations(nums []int, x int) int {
	n := len(nums)
	target := -x
	for _, num := range nums {
		target += num
	}

	if target == 0 {
		return n
	}

	maxLength := -1
	currentSum := 0
	left := 0
	for right := 0; right < n; right++ {
		currentSum += nums[right]
		for currentSum > target && left <= right {
			currentSum -= nums[left]
			left++
		}
		if currentSum == target {
			maxLength = max(maxLength, right-left+1)
		}
	}

	if maxLength == -1 {
		return -1
	}

	return n - maxLength
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}