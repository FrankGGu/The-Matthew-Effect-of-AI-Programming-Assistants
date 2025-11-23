func isIdealPermutation(nums []int) bool {
	n := len(nums)
	for i := 0; i < n; i++ {
		if nums[i] > i+1 || nums[i] < i-1 {
			return false
		}
	}
	return true
}