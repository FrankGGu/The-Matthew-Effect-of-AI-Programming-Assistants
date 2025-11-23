func applyOperations(nums []int) []int {
	for i := 0; i < len(nums)-1; i++ {
		if nums[i] == nums[i+1] {
			nums[i] *= 2
			nums[i+1] = 0
		}
	}

	writeIdx := 0
	for _, num := range nums {
		if num != 0 {
			nums[writeIdx] = num
			writeIdx++
		}
	}

	for writeIdx < len(nums) {
		nums[writeIdx] = 0
		writeIdx++
	}

	return nums
}