func makeArrayNonDecreasing(nums []int) int {
	operations := 0
	for i := 1; i < len(nums); i++ {
		if nums[i] < nums[i-1] {
			operations += nums[i-1] - nums[i]
			nums[i] = nums[i-1]
		}
	}
	return operations
}