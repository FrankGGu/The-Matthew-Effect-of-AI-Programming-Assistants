func maximumTop(nums []int, k int) int {
	n := len(nums)
	if n == 1 {
		if k%2 == 0 {
			return nums[0]
		} else {
			return -1
		}
	}

	if k > n {
		maxVal := -1
		for _, num := range nums {
			if num > maxVal {
				maxVal = num
			}
		}
		return maxVal
	}

	if k == n {
		maxVal := -1
		for i := 0; i < n-1; i++ {
			if nums[i] > maxVal {
				maxVal = nums[i]
			}
		}
		return maxVal
	}

	maxVal := -1
	for i := 0; i < min(k-1, n); i++ {
		if nums[i] > maxVal {
			maxVal = nums[i]
		}
	}

	if k < n {
		if nums[k] > maxVal {
			maxVal = nums[k]
		}
	}

	return maxVal
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}