func goodIndices(nums []int, k int) []int {
	n := len(nums)
	if n < 2*k+1 {
		return []int{}
	}

	left := make([]int, n)
	right := make([]int, n)

	left[0] = 1
	for i := 1; i < n; i++ {
		if nums[i] <= nums[i-1] {
			left[i] = left[i-1] + 1
		} else {
			left[i] = 1
		}
	}

	right[n-1] = 1
	for i := n - 2; i >= 0; i-- {
		if nums[i] <= nums[i+1] {
			right[i] = right[i+1] + 1
		} else {
			right[i] = 1
		}
	}

	result := []int{}
	for i := k; i < n-k; i++ {
		if left[i-1] >= k && right[i+1] >= k {
			result = append(result, i)
		}
	}

	return result
}