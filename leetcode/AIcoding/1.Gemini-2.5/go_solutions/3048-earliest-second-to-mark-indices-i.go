func earliestSecondToMark(nums []int, changeIndices []int) int {
	n := len(nums)
	m := len(changeIndices)

	// Binary search range for the answer `t`
	// Minimum `t` is `n` (if all nums[i] are 0 and we mark one index per second)