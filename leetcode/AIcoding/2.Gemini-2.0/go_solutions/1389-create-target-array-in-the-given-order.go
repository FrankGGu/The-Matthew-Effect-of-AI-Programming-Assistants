func createTargetArray(nums []int, index []int) []int {
	target := make([]int, 0, len(nums))
	for i := 0; i < len(nums); i++ {
		idx := index[i]
		target = append(target, 0)
		copy(target[idx+1:], target[idx:])
		target[idx] = nums[i]
	}
	return target
}