func partitionArray(nums []int, k int) int {
	sort.Ints(nums)

	if len(nums) == 0 {
		return 0
	}

	ans := 1
	minVal := nums[0]

	for i :=