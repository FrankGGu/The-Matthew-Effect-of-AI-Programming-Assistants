func splitArray(nums []int) bool {
	n := len(nums)
	if n < 2 {
		return false
	}

	prefixMax := make([]int, n)
	suffixMin := make([]int, n)

	prefixMax[0] = nums[0]
	for i := 1; i < n; i++ {
		if nums[i] > prefixMax[i-1] {
			prefixMax[i] = nums[i]
		} else {
			prefixMax[i] = prefixMax[i-1]
		}
	}

	suffixMin[n-1] = nums[n-1]
	for i := n - 2; i >= 0; i-- {
		if nums[i] < suffixMin[i+1] {
			suffixMin[i] = nums[i]
		} else {
			suffixMin[i] = suffixMin[i+1]
		}
	}

	for i := 1; i < n; i++ {
		if prefixMax[i-1] < suffixMin[i] {
			return true
		}
	}

	return false
}