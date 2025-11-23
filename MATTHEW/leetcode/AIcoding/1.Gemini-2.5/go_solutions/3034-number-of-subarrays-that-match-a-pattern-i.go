func countMatchingSubarrays(nums []int, pattern []int) int {
	count := 0
	n := len(nums)
	m := len(pattern)

	for i := 0; i <= n-m-1; i++ {
		match := true
		for k := 0; k < m