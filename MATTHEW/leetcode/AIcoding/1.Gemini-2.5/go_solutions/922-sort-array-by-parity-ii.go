func sortArrayByParityII(nums []int) []int {
	n := len(nums)
	i := 0 // Pointer for even indices
	j := 1 // Pointer for odd indices

	for i < n && j < n {
		if nums[i]%2 == 0 {
			i += 2
		} else if nums[j]%2 == 1 {
			j += 2
		} else {
			nums[i], nums[j] = nums[j], nums[i]
			i += 2
			j += 2
		}
	}

	return nums
}