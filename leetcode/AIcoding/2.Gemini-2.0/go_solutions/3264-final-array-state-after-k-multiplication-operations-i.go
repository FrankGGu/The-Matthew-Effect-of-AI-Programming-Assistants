func finalArrayAfterOperations(nums []int, k int) []int {
	n := len(nums)
	if k >= n {
		for i := range nums {
			if nums[i] > 0 {
				nums[i] = 1
			} else if nums[i] < 0 {
				nums[i] = -1
			}
		}
		if k%2 == 0 {
			return nums
		}

		for i := range nums {
			nums[i] *= -1
		}
		return nums
	}

	for i := 0; i < k; i++ {
		if nums[i] > 0 {
			nums[i] = 1
		} else if nums[i] < 0 {
			nums[i] = -1
		}
	}

	negCount := 0
	for i := 0; i < k; i++ {
		if nums[i] < 0 {
			negCount++
		}
	}

	if negCount%2 != 0 {
		for i := 0; i < k; i++ {
			nums[i] *= -1
		}
	}
	return nums
}