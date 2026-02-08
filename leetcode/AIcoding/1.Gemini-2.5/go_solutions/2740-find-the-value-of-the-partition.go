func findValueOfPartition(nums []int) int {
	sort.Ints(nums)

	minDiff := nums[1] - nums[0] // Initialize with the first difference

	for i := 2; i < len(nums); i++ {
		currentDiff :=