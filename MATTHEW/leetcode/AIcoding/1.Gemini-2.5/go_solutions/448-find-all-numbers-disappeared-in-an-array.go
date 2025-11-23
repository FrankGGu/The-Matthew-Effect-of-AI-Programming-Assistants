func findDisappearedNumbers(nums []int) []int {
	n := len(nums)
	for i := 0; i < n; i++ {
		val := nums[i]
		if val < 0 {
			val = -val
		}

		idx := val - 1

		if nums[idx] > 0 {
			nums[idx] = -nums[idx]
		}
	}

	var result []int
	for i := 0; i < n; i++ {
		if nums[i] > 0 {
			result = append(result, i+1)
		}
	}

	return result
}