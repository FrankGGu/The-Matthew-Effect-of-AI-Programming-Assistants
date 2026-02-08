func maxNumOfMarkedIndices(nums []int) int {
	sort.Ints(nums)
	n := len(nums)

	// 'left' pointer for the first half (smaller elements)
	// 'right' pointer for the second half (larger elements)
	left :=