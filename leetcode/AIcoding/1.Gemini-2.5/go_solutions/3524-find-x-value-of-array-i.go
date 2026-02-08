func specialArray(nums []int) int {
	n := len(nums)

	// Sort the array in ascending order.
	// This helps in efficiently counting elements greater than or equal to x.
	sort.Ints(nums)

	// Iterate through possible