func minPatches(nums []int, n int) int {
	patches := 0
	i := 0
	reach := 1
	for reach <= n {
		if i < len(nums) && nums[i] <= reach {
			reach += nums[i]
			i++
		} else {
			reach += reach
			patches++
		}
	}
	return patches
}