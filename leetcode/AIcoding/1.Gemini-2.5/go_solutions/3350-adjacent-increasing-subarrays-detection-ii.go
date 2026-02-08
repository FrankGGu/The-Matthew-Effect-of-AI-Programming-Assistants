func solve(nums []int) bool {
	n := len(nums)

	if n < 2 {
		return false
	}

	prefixInc := make([]bool, n)
	suffixInc := make([]bool, n)

	prefixInc[0] = true
	for i := 1; i < n; i++ {
		prefixInc[i] = prefixInc[i-1] && (nums[i] > nums[i-1])
	}

	suffixInc[n-1] = true
	for i := n - 2; i >= 0; i-- {
		suffixInc[i] = suffixInc[i+1] && (nums[i] < nums[i+1])
	}

	for k := 0; k < n-1; k++ {
		if prefixInc[k] && suffixInc[k+1] {
			return true
		}
	}

	return false
}