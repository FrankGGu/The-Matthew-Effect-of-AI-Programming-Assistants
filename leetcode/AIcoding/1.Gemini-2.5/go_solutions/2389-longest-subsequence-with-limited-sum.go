func answerQueries(nums []int, queries []int) []int {
	sort.Ints(nums)

	prefixSums := make([]int, len(nums))
	if len(nums) > 0 {
		prefixSums[0] = nums[0]
		for i :=