func specialArray(nums []int) int {
	sort.Ints(nums)
	n := len(nums)

	// Iterate through possible values of x from 1 to n.
	// x represents the potential "special" value.
	for x := 1; x <= n; x