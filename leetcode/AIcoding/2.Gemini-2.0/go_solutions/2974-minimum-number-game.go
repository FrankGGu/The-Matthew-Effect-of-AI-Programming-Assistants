func numberGame(nums []int) []int {
	n := len(nums)
	res := make([]int, n)
	for i := 0; i < n; i += 2 {
		if nums[i] > nums[i+1] {
			res[i] = nums[i+1]
			res[i+1] = nums[i]
		} else {
			res[i] = nums[i]
			res[i+1] = nums[i+1]
		}
	}
	return res
}