func minOperations(nums []int) int {
	count := 0
	for i := 0; i < len(nums); i++ {
		if nums[i] == 0 {
			count++
			if i+1 < len(nums) {
				nums[i+1] = 1 - nums[i+1]
			}
		}
	}
	return count
}