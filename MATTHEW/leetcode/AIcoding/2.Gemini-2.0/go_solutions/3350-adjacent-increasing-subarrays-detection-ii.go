func check(nums []int) bool {
	n := len(nums)
	count := 0
	for i := 1; i < n; i++ {
		if nums[i-1] > nums[i] {
			count++
		}
	}
	if count == 0 {
		return true
	}
	if count == 1 && nums[n-1] > nums[0] {
		return false
	}
	if count > 1 {
		return false
	}
	return true
}